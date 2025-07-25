import 'dart:math';
import 'package:flutter/material.dart';

class HeartRain extends StatefulWidget {
  const HeartRain({super.key});

  @override
  State<HeartRain> createState() => _HeartRainState();
}

class _HeartRainState extends State<HeartRain> with TickerProviderStateMixin {
  final int numberOfHearts = 30;
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfHearts; i++) {
      final duration = Duration(milliseconds: 3000 + random.nextInt(3000));
      final controller = AnimationController(
        vsync: this,
        duration: duration,
      )..repeat();

      final animation = Tween<double>(begin: -100, end: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height + 100).animate(controller);

      _controllers.add(controller);
      _animations.add(animation);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(numberOfHearts, (index) {
        final left = random.nextDouble() * MediaQuery.of(context).size.width;
        final size = 20.0 + random.nextDouble() * 40.0;
        final color = Colors.primaries[random.nextInt(Colors.primaries.length)].withOpacity(0.8);

        return AnimatedBuilder(
          animation: _animations[index],
          builder: (_, __) {
            return Positioned(
              top: _animations[index].value,
              left: left,
              child: Icon(
                Icons.favorite,
                color: color,
                size: size,
              ),
            );
          },
        );
      }),
    );
  }
}
