import 'dart:math';
import 'package:flutter/material.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

class HeartRain extends StatefulWidget {
  const HeartRain({super.key});

  @override
  State<HeartRain> createState() => _HeartRainState();
}

class _HeartRainState extends State<HeartRain> with TickerProviderStateMixin {
  final int numberOfHearts = 30;
  final List<_HeartData> _hearts = [];
  final Random random = Random();

  final List<Color> heartColors = [
    const Color(0xFFFFC0CB),
    const Color(0xFFE75480),
    const Color(0xFFDA70D6),
    const Color(0xFFBA55D3),
    const Color(0xFF8A2BE2),
    const Color(0xFFDB7093),
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfHearts; i++) {
      final fallDuration = Duration(milliseconds: 3000 + random.nextInt(3000));
      final pulseDuration = Duration(milliseconds: 1000 + random.nextInt(1000));

      final fallController = AnimationController(vsync: this, duration: fallDuration)..repeat();
      final pulseController = AnimationController(vsync: this, duration: pulseDuration)..repeat(reverse: true);

      // ignore: deprecated_member_use
      final screenHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
      final fallAnimation = Tween<double>(begin: -100, end: screenHeight + 100).animate(CurvedAnimation(
        parent: fallController,
        curve: Curves.linear,
      ));

      final pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ));

      _hearts.add(_HeartData(
        fallController: fallController,
        fallAnimation: fallAnimation,
        pulseController: pulseController,
        pulseAnimation: pulseAnimation,
        left: random.nextDouble(), // % da largura da tela
        color: heartColors[random.nextInt(heartColors.length)],
        size: 20.0 + random.nextDouble() * 40.0,
      ));
    }
  }

  @override
  void dispose() {
    for (var heart in _hearts) {
      heart.fallController.dispose();
      heart.pulseController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(
      builder: (context, uiController, _) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Stack(
          children: _hearts.map((heart) {
            return AnimatedBuilder(
              animation: Listenable.merge([heart.fallAnimation, heart.pulseAnimation]),
              builder: (_, __) {
                return Positioned(
                  top: heart.fallAnimation.value,
                  left: heart.left * screenWidth,
                  child: Transform.scale(
                    scale: heart.pulseAnimation.value,
                    child: Icon(
                      Icons.favorite,
                      color: heart.color,
                      size: uiController.isMobile ? heart.size * 0.7 : heart.size,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          // ignore: deprecated_member_use
                          color: heart.color.withOpacity(0.4),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class _HeartData {
  final AnimationController fallController;
  final Animation<double> fallAnimation;
  final AnimationController pulseController;
  final Animation<double> pulseAnimation;
  final double left;
  final double size;
  final Color color;

  _HeartData({
    required this.fallController,
    required this.fallAnimation,
    required this.pulseController,
    required this.pulseAnimation,
    required this.left,
    required this.size,
    required this.color,
  });
}
