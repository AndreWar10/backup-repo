import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';
import 'package:love/start/controllers/start_controller.dart';
import 'package:love/start/pages/start_page.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiController()),
        ChangeNotifierProvider(create: (_) => StartController()),
      ],
      child: const MyApp(),
    )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        context.read<UiController>().changeTypeUi(sizeInfo.deviceScreenType);
        return MaterialApp(
          title: 'Valentine Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppFonts.poppins500,
          ),
          home: const StartPage(),
        );
      }
    );
  }
}