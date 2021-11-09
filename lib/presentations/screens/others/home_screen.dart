import 'package:flutter/material.dart'; //cupertino.dart cho iOS
import 'package:mobile_app/presentations/widgets/main_app_name.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //print("${SizeConfig.screenHeight} + / + ${SizeConfig.screenWidth}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.0384),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              MainAppName(
                  text: "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM"),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              CustomizedButton(
                text: "Đăng nhập",
                onPressed: () {
                  Navigator.pushNamed(context, '/loginscreen');
                },
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'SISTRAIN All rights reserved',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
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
