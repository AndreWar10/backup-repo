import 'package:flutter/material.dart';
import 'package:love/home/pages/home_page.dart';
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.transparent,
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
                    Positioned.fill(
                      child: HomePage(),
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