import 'package:flutter/material.dart';

import 'constant.dart';

class CustomizedButton extends StatelessWidget {
  final String text;
  final double width, height, radius;
  Color bgColor;
  Color fgColor;
  VoidCallback onPressed;
  double fontSize;
  CustomizedButton(
      {this.text = "Tên nút",
      this.width = 250,
      this.height = 60,
      this.radius = 60,
      this.bgColor = Constants.mainColor,
      this.fgColor = Colors.white,
      this.onPressed,
      this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: width,
        height: height,
        // ignore: deprecated_member_use
        child: RaisedButton(
          disabledColor: Colors.grey,
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: fgColor),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class AnnotationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [Column()],
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Constants.mainColor),
                strokeWidth: 6.0,
              )),
          SizedBox(
            height: 30,
          ),
          Text(
            "Đang tải dữ liệu",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class IconAnnotation extends StatelessWidget {
  final Color color;
  IconAnnotation({this.color = Colors.blue});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 30,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
    );
  }
}

class TextAnnotation extends StatelessWidget {
  final String text;
  TextAnnotation({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
