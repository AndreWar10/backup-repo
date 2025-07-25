import 'package:flutter/material.dart';
import 'package:love/start/components/exploding_hearts.dart';
import 'package:love/start/components/heart_rain.dart';
import 'package:love/start/controllers/start_controller.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StartController>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
              ),
            ),
          ),
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

          if(controller.isOpen)...{
            HeartRain(),
          }
        ],
      ),
    );
  }
}