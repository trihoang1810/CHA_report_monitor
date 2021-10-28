import 'package:flutter/material.dart';

class ExceptionErrorState extends StatelessWidget {
  String title;

  ///Nếu không có message, thì phải gán message = ""
  String message;
  String imageDirectory;
  double imageHeight;
  double height;
  double width;
  double distanceTextImage;
  ExceptionErrorState(
      {this.title = "Đây là title báo lỗi",
      this.message = "Đây là message báo lỗi",
      this.imageDirectory = 'lib/assets/sad_face_cloud_2.png',
      this.imageHeight = 100,
      this.height = 250,
      this.width = 300,
      this.distanceTextImage = 30});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imageDirectory),
            height: imageHeight,
          ),
          SizedBox(
            height: distanceTextImage,
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          message == ""
              ? SizedBox(
                  height: 1,
                )
              : FittedBox(
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 20,
                        height:
                            1.5), //do ko cho null dc nen cho fontSize nho xiu
                    textAlign: TextAlign.center,
                  ),
                )
        ],
      ),
    );
  }
}
