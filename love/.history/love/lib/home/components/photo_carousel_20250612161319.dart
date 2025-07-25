import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PhotoCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 250, // altura real do carrossel
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
    );
  }
}
