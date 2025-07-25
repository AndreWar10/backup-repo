import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

class PhotoCarousel extends StatelessWidget {

  const PhotoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrls = [
      'assets/we/1.jpg',
      'assets/we/2.jpg',
      'assets/we/3.jpg',
      'assets/we/4.png',
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
        return SizedBox(
          width: uiController.isMobile ? double.infinity : MediaQuery.of(context).size.width * 0.8,
          child: CarouselSlider(
            options: CarouselOptions(
              // height: 600,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.easeInOut,
              autoPlayAnimationDuration: Duration(seconds: 2),
            ),
            items: imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      }
    );
  }
}
