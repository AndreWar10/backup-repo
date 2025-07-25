import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UiController extends ChangeNotifier {
  UiController();

  bool isMobile = false;

  void changeTypeUi(DeviceScreenType typeScreen) {
    if(isMobile == false && (typeScreen == DeviceScreenType.mobile)) {
      isMobile = true;
    } else if(isMobile == true && (typeScreen != DeviceScreenType.mobile)) {
      isMobile = false;
    }
    print(isMobile ? 'MOBILE UI' : 'WEB UI');
    notifyListeners();
  }
}
