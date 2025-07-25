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
        title: 'Amor de André & Juliana',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            bodyLarge: TextStyle(fontSize: 18.0),
          ),
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
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text('🌸 André & Juliana 💖'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Uma Homenagem ao Amor 💕',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Esta página celebra a história de André e Juliana: um romance repleto de carinho, aventuras e sorrisos. Cada foto conta um pedaço dessa linda jornada! 📸',
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: const [
                  Text(
                    '💬 Mensagens de Amor',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.pinkAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '"O amor não se vê com os olhos, mas com o coração." – William Shakespeare',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    '💌 Quer deixar uma mensagem para o casal?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Em breve: espaço para mensagens com Firebase 💬',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
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
    final controller = PageController(viewportFraction: 0.8);
    final carouselProvider = Provider.of<CarouselController>(context);

    final List<String> imageUrls = [
      'https://super.abril.com.br/wp-content/uploads/2001/06/afinal-o-que-ecc81-amor.jpeg?crop=1&resize=1212,909',
      'https://super.abril.com.br/wp-content/uploads/2001/06/afinal-o-que-ecc81-amor.jpeg?crop=1&resize=1212,909',
      'https://super.abril.com.br/wp-content/uploads/2001/06/afinal-o-que-ecc81-amor.jpeg?crop=1&resize=1212,909',
      'https://super.abril.com.br/wp-content/uploads/2001/06/afinal-o-que-ecc81-amor.jpeg?crop=1&resize=1212,909',
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
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
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