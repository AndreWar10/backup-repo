import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';
import 'package:love/home/components/love_timer.dart';
import 'package:love/home/components/photo_carousel.dart';
import 'package:love/home/components/text_of_love.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final photos = [
      'assets/we/1.jpg',
      'assets/we/2.jpg',
      'assets/we/3.jpg',
      'assets/we/4.jpg',
      // 'assets/we/5.jpg',
      'assets/we/6.jpg',
      'assets/we/7.jpg',
      'assets/we/8.jpg',
      'assets/we/9.jpg',
      'assets/we/10.jpg',
      'assets/we/11.jpg',
      'assets/we/12.png',
      'assets/we/13.jpg',
      'assets/we/14.jpg',
      'assets/we/15.jpg',
      'assets/we/16.png',
      'assets/we/17.jpg',
      'assets/we/18.jpg',
    ];
    return Consumer<UiController>(
      builder: (context, uiController, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36),
              Text(
                'Feliz Dia dos Namorados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: uiController.isMobile ? 24 : 50,
                  fontFamily: AppFonts.way,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Andre ❤️ Juliana',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: AppFonts.way,),
              ),
              const SizedBox(height: 30),
              PhotoCarousel(imageUrls: photos),
              const SizedBox(height: 16),
              LoveTimer(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextOfLove()
            ],
          ),
        );
      }
    );
  }
}