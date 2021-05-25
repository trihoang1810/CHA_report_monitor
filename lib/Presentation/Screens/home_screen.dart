import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/main_app_name.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loginButton = new CustomizedButton(
      text: "Đăng nhập",
      onPressed: () {
        Navigator.pushNamed(context, '/loginscreen');
      },
    );

    final rightsReserved = Text(
      'SISTRAIN All rights reserved',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 40),
            MainAppName(),
            SizedBox(
              height: 80.0,
            ),
            loginButton,
            SizedBox(height: 300),
            rightsReserved
          ],
        ),
      ),
    );
  }
}
