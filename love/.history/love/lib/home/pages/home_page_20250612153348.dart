import 'package:flutter/material.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(
      builder: (context, uiController, __) {
        return Positioned(
          top: 100,
          child: Column(
            children: [
              Text(
                'Feliz Dia dos Namorados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: uiController.isMobile ? 24 : 50,
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
        );
      }
    );
  }
}