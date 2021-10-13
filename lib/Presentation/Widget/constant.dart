import 'package:flutter/material.dart';

double screenWidthGlobal;

class Constants {
  static const String baseUrl =
      //"https://storagewebapi20210714122113.azurewebsites.net/";
      "https://phong-kiem-tra-chat-luong-sp.herokuapp.com";
  static const Color mainColor = Color(0xff001D37);
  static const Color secondaryColor = Color(0xff00294D);
  static const Duration timeOutLimitation = Duration(seconds: 10);
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth; //logical pixel
  static double screenHeight; //logical pixel
  double aspect;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenWidthGlobal = screenWidth; //2; 1.777778
  }
}
