import 'dart:async';

import 'package:flutter/material.dart';
import 'package:algolia_client_search/algolia_client_search.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<SearchController>(create: (context) => SearchController())],      
      child: MaterialApp(title: 'Algolia Search Example', home: SearchPage()),
    );
  }
}

enum SuggestionType { term, category, brand }

class SuggestionItem {
  final String label;
  final SuggestionType type;

  SuggestionItem({required this.label, required this.type});
}

class SearchController extends ChangeNotifier {
  final _client = SearchClient(appId: 'VSCMPGMHA0', apiKey: '399f32e0b0991841f84715179cd1278d');
  final TextEditingController searchController = TextEditingController();
  String get query => searchController.text;

  // Filtros aplicados
  final List<String> appliedCategories = [];
  final List<String> appliedBrands = [];
  final List<String> appliedSellers = [];

  // Filtros temporários (no modal)
  final List<String> tempCategories = [];
  final List<String> tempBrands = [];
  final List<String> tempSellers = [];

  SearchState state = SearchState.initial();

  List<SuggestionItem> suggestions = [];

  Future<void> fetchAutocompleteSuggestions() async {
    try {
      final indexNameSuggestions = 'ldm_products_query_suggestions';
      final indexNameFacets = 'ldm_app';

      final requests = [
        // Sugestões de termos
        SearchForHits(
          indexName: indexNameSuggestions,
          query: query,
          hitsPerPage: 5,
        ),
      ];

      if(query.isEmpty) {
        requests.add(
          // Facet: categorias
          SearchForHits(
            indexName: indexNameFacets,
            query: query,
            facets: ['categoryLevels.lvl0'],
            filters: null,
            hitsPerPage: 0,
            maxValuesPerFacet: 5,
          ),
        );

        requests.add(
          // Facet: marcas
          SearchForHits(
            indexName: indexNameFacets,
            query: query,
            facets: ['brand.name'],
            filters: null,
            // facetQuery: userInput,
            hitsPerPage: 0,
            maxValuesPerFacet: 5,
          ),
        );
      }

      final response = await _client.search(
        searchMethodParams: SearchMethodParams(
          requests: requests,
        ),
      );

      final results = response.results.toList();

      suggestions.clear();

      final terms = (results[0]['hits'] as List).map((hit) {
        return SuggestionItem(label: hit['query'] as String, type: SuggestionType.term);
      }).toList();

      List<SuggestionItem> categories = [];
      List<SuggestionItem> brands = [];

      if (results.length > 1 && results[1]['facets']?['categoryLevels.lvl0'] != null) {
        categories = (results[1]['facets']['categoryLevels.lvl0'] as Map<String, dynamic>)
            .keys
            .map((k) => SuggestionItem(label: k, type: SuggestionType.category))
            .toList();
      }

      if (results.length > 2 && results[2]['facets']?['brand.name'] != null) {
        brands = (results[2]['facets']['brand.name'] as Map<String, dynamic>)
            .keys
            .map((k) => SuggestionItem(label: k, type: SuggestionType.brand))
            .toList();
      }

      suggestions = [...terms, ...categories, ...brands];
      notifyListeners();

      notifyListeners();
    } catch (e) {
      print('Erro ao buscar sugestões: $e');
    }
  }

  void openFilterModal() {
    tempCategories..clear()..addAll(appliedCategories);
    tempBrands..clear()..addAll(appliedBrands);
    tempSellers..clear()..addAll(appliedSellers);
    previewFilters();
  }

  void toggleTempCategory(String category) {
    tempCategories.contains(category) ? tempCategories.remove(category) : tempCategories.add(category);
    previewFilters();
    notifyListeners();
  }

  void toggleTempBrand(String brand) {
    tempBrands.contains(brand) ? tempBrands.remove(brand) : tempBrands.add(brand);
    previewFilters();
    notifyListeners();
  }

  void toggleTempSeller(String seller) {
    tempSellers.contains(seller) ? tempSellers.remove(seller) : tempSellers.add(seller);
    previewFilters();
    notifyListeners();
  }

  Future<void> applyFilters() async {
    appliedCategories..clear()..addAll(tempCategories);
    appliedBrands..clear()..addAll(tempBrands);
    appliedSellers..clear()..addAll(tempSellers);
    await search();
  }

  List<String> _buildFilters() {
    final filters = <String>[];
    filters.addAll(appliedCategories.map((c) => 'category.name:"$c"'));
    filters.addAll(appliedBrands.map((b) => 'brand.name:"$b"'));
    filters.addAll(appliedSellers.map((s) => 'marketplace.sellerName:"$s"'));
    return filters;
  }

  List<String> _buildTempFilters() {
    final filters = <String>[];
    filters.addAll(tempCategories.map((c) => 'category.name:"$c"'));
    filters.addAll(tempBrands.map((b) => 'brand.name:"$b"'));
    filters.addAll(tempSellers.map((s) => 'marketplace.sellerName:"$s"'));
    return filters;
  }

  Future<void> search() async {
    state = state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final facets = ['category.name', 'brand.name', 'marketplace.sellerName'];
      final filters = _buildFilters();
      final indexName = 'ldm_app';

      final mainQuery = SearchForHits(
        indexName: indexName,
        query: query,
        filters: filters.isNotEmpty ? filters.join(' AND ') : null,
        hitsPerPage: 20,
      );

      final facetQueries = facets.map((facetField) {
        final filtersExcluding = filters.where((f) => !f.contains(facetField)).toList();
        return SearchForHits(
          indexName: indexName,
          query: query,
          filters: filtersExcluding.isNotEmpty ? filtersExcluding.join(' AND ') : null,
          facets: [facetField],
          hitsPerPage: 0,
          maxValuesPerFacet: 100,
        );
      }).toList();

      final response = await _client.search(
        searchMethodParams: SearchMethodParams(
          strategy: SearchStrategy.none,
          requests: [mainQuery, ...facetQueries],
        ),
      );

      final results = response.results.toList();
      final hits = results.first['hits'] as List;

      state = state.copyWith(
        results: hits,
        categoryFacets: Map<String, int>.from(results[1]['facets']['category.name'] ?? {}),
        brandFacets: Map<String, int>.from(results[2]['facets']['brand.name'] ?? {}),
        sellerFacets: Map<String, int>.from(results[3]['facets']['marketplace.sellerName'] ?? {}),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  Future<void> previewFilters() async {
    state = state.copyWith(isLoading: false, error: null);
    notifyListeners();

    try {
      final facets = ['category.name', 'brand.name', 'marketplace.sellerName'];
      final filters = _buildTempFilters();
      final indexName = 'ldm_app';

      final facetQueries = facets.map((facetField) {
        final filtersExcluding = filters.where((f) => !f.contains(facetField)).toList();
        return SearchForHits(
          indexName: indexName,
          query: query,
          filters: filtersExcluding.isNotEmpty ? filtersExcluding.join(' AND ') : null,
          facets: [facetField],
          hitsPerPage: 0,
          maxValuesPerFacet: 100,
        );
      }).toList();

      final response = await _client.search(
        searchMethodParams: SearchMethodParams(
          strategy: SearchStrategy.none,
          requests: facetQueries,
        ),
      );

      final results = response.results.toList();

      state = state.copyWith(
        categoryFacets: Map<String, int>.from(results[0]['facets']['category.name'] ?? {}),
        brandFacets: Map<String, int>.from(results[1]['facets']['brand.name'] ?? {}),
        sellerFacets: Map<String, int>.from(results[2]['facets']['marketplace.sellerName'] ?? {}),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }
}

void showFilterModal(BuildContext context) {
  context.read<SearchController>().openFilterModal();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Consumer<SearchController>(
          builder: (context, searchController, __) {
            final state = searchController.state;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FacetChipsWidget(
                    title: 'Categorias',
                    facetValues: state.categoryFacets,
                    selectedValues: searchController.tempCategories,
                    onSelect: searchController.toggleTempCategory,
                  ),
                  FacetChipsWidget(
                    title: 'Marcas',
                    facetValues: state.brandFacets,
                    selectedValues: searchController.tempBrands,
                    onSelect: searchController.toggleTempBrand,
                  ),
                  FacetChipsWidget(
                    title: 'Vendido por',
                    facetValues: state.sellerFacets,
                    selectedValues: searchController.tempSellers,
                    onSelect: searchController.toggleTempSeller,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await searchController.applyFilters();
                      Navigator.pop(context);
                    },
                    child: const Text('Aplicar Filtros'),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class FacetChipsWidget extends StatefulWidget {
  final String title;
  final Map<String, int> facetValues;
  final List<String> selectedValues;
  final Function(String) onSelect;

  const FacetChipsWidget({
    Key? key,
    required this.title,
    required this.facetValues,
    required this.selectedValues,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<FacetChipsWidget> createState() => _FacetChipsWidgetState();
}

class _FacetChipsWidgetState extends State<FacetChipsWidget> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final entries = widget.facetValues.entries.toList();
    final displayEntries = showAll ? entries : entries.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayEntries.map((entry) {
            final isSelected = widget.selectedValues.contains(entry.key);
            return ChoiceChip(
              label: Text('${entry.key} (${entry.value})'),
              selected: isSelected,
              onSelected: (_) => widget.onSelect(entry.key),
              selectedColor: Colors.orange,
            );
          }).toList(),
        ),
        if (entries.length > 10)
          TextButton(
            onPressed: () {
              setState(() {
                showAll = !showAll;
              });
            },
            child: Text(showAll ? 'Ver menos' : 'Ver mais...'),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  Timer? _debounce;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    final controller = context.read<SearchController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.search();
    });

    controller.searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        controller.fetchAutocompleteSuggestions();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.search();
    });
  }

  void _performSearch() {
    context.read<SearchController>().search();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SearchController>();
    final state = controller.state;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.searchController,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: 'Buscar produto...',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _performSearch(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _performSearch,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilterModal(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_focusNode.hasFocus && controller.suggestions.isNotEmpty)
              Expanded(
                child: ListView(
                  children: controller.suggestions.map((s) {
                    Icon icon;
                    switch (s.type) {
                      case SuggestionType.term:
                        icon = const Icon(Icons.search);
                        break;
                      case SuggestionType.category:
                        icon = const Icon(Icons.category);
                        break;
                      case SuggestionType.brand:
                        icon = const Icon(Icons.local_offer);
                        break;
                    }

                    return ListTile(
                      leading: icon,
                      title: Text(s.label),
                      onTap: () {
                        controller.searchController.text = s.label;
                        controller.search();
                        _focusNode.unfocus();
                      },
                    );
                  }).toList(),
                ),
              )
            else if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (state.error != null)
              Text('Erro: ${state.error}')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final product = state.results[index];
                    return ListTile(
                      title: Text(
                        'ID: ${product['productId']}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product['title'] ?? 'Produto sem nome',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),

    );
  }
}


class SearchState {
  final List<dynamic> results;
  final Map<String, int> categoryFacets;
  final Map<String, int> brandFacets;
  final Map<String, int> sellerFacets;
  final bool isLoading;
  final String? error;

  SearchState({
    required this.results,
    required this.categoryFacets,
    required this.brandFacets,
    required this.sellerFacets,
    required this.isLoading,
    this.error,
  });

  factory SearchState.initial() {
    return SearchState(
      results: [],
      categoryFacets: {},
      brandFacets: {},
      sellerFacets: {},
      isLoading: false,
    );
  }

  SearchState copyWith({
    List<dynamic>? results,
    Map<String, int>? categoryFacets,
    Map<String, int>? brandFacets,
    Map<String, int>? sellerFacets,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      results: results ?? this.results,
      categoryFacets: categoryFacets ?? this.categoryFacets,
      brandFacets: brandFacets ?? this.brandFacets,
      sellerFacets: sellerFacets ?? this.sellerFacets,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}