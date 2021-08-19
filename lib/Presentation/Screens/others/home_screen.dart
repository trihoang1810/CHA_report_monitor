import 'package:flutter/material.dart'; //cupertino.dart cho iOS
import 'package:mobile_app/Presentation/Widget/main_app_name.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //print("${SizeConfig.screenHeight} + / + ${SizeConfig.screenWidth}");
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center( 
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.0384),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                MainAppName(text: "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM"),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                loginButton,
              ],
            ),
          ),
          Column(
            children: [
              rightsReserved,
              SizedBox(
                height: (SizeConfig.screenHeight / 100),
              )
            ],
          ),
        ],
      ),
    );
  }
}
