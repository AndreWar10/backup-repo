import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AmorApp());
}

class AmorApp extends StatelessWidget {
  const AmorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarouselController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'André & Juliana',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class CarouselController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('André ❤️ Juliana'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Uma homenagem ao amor de André e Juliana 💑',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Essa é uma jornada de carinho, cumplicidade e muitos sorrisos. Aqui celebramos momentos especiais, cheios de amor e eternizados em fotos.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const PhotoCarousel(),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                '"O amor não se vê com os olhos, mas com o coração." – William Shakespeare',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoCarousel extends StatelessWidget {
  const PhotoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.85);
    final carouselProvider = Provider.of<CarouselController>(context);

    final List<String> imageUrls = [
      // Esses links devem vir do Firebase futuramente!
      'https://via.placeholder.com/600x400?text=Foto+1',
      'https://via.placeholder.com/600x400?text=Foto+2',
      'https://via.placeholder.com/600x400?text=Foto+3',
    ];

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: controller,
            itemCount: imageUrls.length,
            onPageChanged: (index) => carouselProvider.updateIndex(index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageUrls.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: carouselProvider.currentIndex == entry.key ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: carouselProvider.currentIndex == entry.key
                    ? Colors.pinkAccent
                    : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
