import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

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
    return Consumer<UiController>(
      builder: (context, uiController, __) {
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
                    child: Icon(
                      Icons.favorite,
                      size: uiController.isMobile ? 200 : 400,
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
                    child: Icon(
                      Icons.favorite,
                      size: uiController.isMobile ? 100 : 250,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _bigHeartController,
                builder: (_, __) => Transform.scale(
                  scale: 1 + _bigHeartController.value * 0.2, 
                  child: Opacity(
                    opacity: 1,
                    child: Text(
                      'Clique-me',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.way,
                        fontSize: uiController.isMobile ? 16 :22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
