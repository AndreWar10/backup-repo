import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ValentineController(),
      child: const MyApp(),
    ),
  );
}

class ValentineController with ChangeNotifier {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void close() {
    _isOpen = false;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pacifico'),
      home: const ValentinePage(),
    );
  }
}

class ValentinePage extends StatelessWidget {
  const ValentinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ValentineController>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color.fromRGBO(103, 58, 183, 0.7)),
          Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: controller.isOpen ? 1000 : 1000,
              curve: Curves.easeInOut,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (!controller.isOpen)...{
                    GestureDetector(
                      onTap: controller.toggle,
                      child: ExplodingHearts(),
                    ),
                  },

                  if (controller.isOpen)...{
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: controller.close,
                      ),
                    ),
                  },

                  if (controller.isOpen) ...{
                    const Positioned(
                      top: 100,
                      child: Column(
                        children: [
                          Text(
                            'I love you baby',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 3,
                                  color: Colors.black38,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Be my valentine?',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '~Andre ❤️ Juliana',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  }                    
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExplodingHearts extends StatefulWidget {
  const ExplodingHearts({super.key});

  @override
  State<ExplodingHearts> createState() => _ExplodingHeartsState();
}

class _ExplodingHeartsState extends State<ExplodingHearts> with TickerProviderStateMixin {
  late final AnimationController _bigHeartController;
  late final AnimationController _smallHeartController;

  @override
  void initState() {
    super.initState();
    _bigHeartController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _smallHeartController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _bigHeartController.dispose();
    _smallHeartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _bigHeartController,
            builder: (_, __) => Transform.scale(
              scale: 1 + _bigHeartController.value * 1.2,
              child: Opacity(
                opacity: 1 - _bigHeartController.value,
                child: const Icon(
                  Icons.favorite,
                  size: 400,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),
          Icon(
                  Icons.favorite,
                  size: 250, // aumentei o tamanho
                  color: Colors.pink,
                ),
          AnimatedBuilder(
            animation: _smallHeartController,
            builder: (_, __) => Transform.scale(
              scale: 1 + _smallHeartController.value * 0.4, 
              child: Opacity(
                opacity: 1 - _smallHeartController.value,
                child: Text(
                  'Clique-me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
