import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Constants.mainColor),
            ),
            minimumSize: Size.fromHeight(40),
            primary: Colors.white,
          ),
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Constants.mainColor),
            ),
          ),
          onPressed: onClicked,
        ),
      );
}
