import 'package:flutter/material.dart';
import 'package:love/home/components/background_music_player.dart';
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
    return Consumer<UiController>(
      builder: (context, uiController, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BackgroundMusicPlayer(),
              HeaderInfo(isMobile: uiController.isMobile,),
              const SizedBox(height: 30),
              PhotoCarousel(),
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