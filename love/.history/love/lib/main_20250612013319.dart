import 'package:flutter/material.dart';
import 'package:love/start/controllers/start_controller.dart';
import 'package:love/start/pages/start_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StartController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pacifico'),
      home: const StartPage(),
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

  @override
  void initState() {
    super.initState();
    _bigHeartController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _bigHeartController.dispose();
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
          AnimatedBuilder(
            animation: _bigHeartController,
            builder: (_, __) => Transform.scale(
              scale: 1 + _bigHeartController.value * 0.1,
              child: Opacity(
                opacity: 1,
                child: const Icon(
                  Icons.favorite,
                  size: 250,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _bigHeartController,
            builder: (_, __) => Transform.scale(
              scale: 1 + _bigHeartController.value * 0.1, 
              child: Opacity(
                opacity: 1,
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
