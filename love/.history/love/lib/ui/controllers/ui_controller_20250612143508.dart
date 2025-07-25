import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;

class UiController extends ChangeNotifier {
  UiController();

  bool isMobile = false;

  void changeTypeUi(DeviceScreenType typeScreen) {
    if (isWebMobile()) {}
    if (isMobile == false && (typeScreen == DeviceScreenType.mobile)) {
      isMobile = true;
    } else if (isMobile == true && (typeScreen != DeviceScreenType.mobile)) {
      isMobile = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  bool isWebMobile() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    return userAgent.contains('iphone') ||
        userAgent.contains('android') ||
        userAgent.contains('ipad') ||
        userAgent.contains('mobile');
  }
}
