import 'package:flutter/material.dart';
import 'package:love/home/components/header_info.dart';
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
              HeaderInfo(isMobile: uiController.isMobile,),
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
              TextOfLove(),
              const SizedBox(height: 16),
            ],
          ),
        );
      }
    );
  }
}