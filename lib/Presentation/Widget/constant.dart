import 'package:flutter/material.dart';

double screenWidthGlobal;

class Constants {
  static const String baseUrl =
      "http://192.168.1.13:8083";
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

//SizeConfig.init(context);
// 2000:1000 <-- physical pixel --> chữ "a" với điểm ảnh là 14
//CSS ratio: 2, 3, 1, 4
//LP=PP/CSS ratio
//LP = 5000/250 --> chữ "a" với điểm anh là 14 => size chữ trong flutter là dựa theo logical pixel
//14 cũng là fontSize mặc định của Flutter khi không khai báo fontSize
//Hạn chế của flutter là width + height của các Widget(Container, SizedBox...)
//aspectRatio