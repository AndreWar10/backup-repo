import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';

class HeaderInfo extends StatelessWidget {
  final bool isMobile;
  const HeaderInfo({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 36),
        Builder(
          builder: (context) {
            return Text(
              'Feliz Dia dos Namorados!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 24 : 50,
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
            );
          }
        ),
        SizedBox(height: 20),
        Text(
          'Andre ❤️ Juliana',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: AppFonts.way,
            shadows: [
              Shadow(
                offset: Offset(2, 4),
                blurRadius: 5,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
