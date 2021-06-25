import 'package:flutter/material.dart';
import 'package:mobile_app/models/func.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
// import 'package:mobile_app/presentation/widget/constant.dart';
// import 'package:mobile_app/presentation/widget/constant.dart';

// ignore: must_be_immutable
class ModeScreen extends StatefulWidget {
  @override
  _ModeScreenState createState() => new _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final logo =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Image.asset(
        'lib/assets/CHAlogo.png',
        width: SizeConfig.screenWidth * 0.3056,
      ),
      SizedBox(width: SizeConfig.screenWidth * 0.0764),
      Image.asset(
        'lib/assets/BK_VIAMLAB.png',
        width: SizeConfig.screenWidth * 0.3056,
      ),
    ]);

    final reportButton = new CustomizedButton(
      text: 'BÁO CÁO',
      onPressed: () {
        Navigator.pushNamed(context, '/reportmodescreen');
      },
    );
    final monitorButton = new CustomizedButton(
      text: 'GIÁM SÁT',
      onPressed: () {
        Navigator.pushNamed(context, '/monitormodescreen');
      },
    );
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Constants.secondaryColor,
        ),
        child: Drawer(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Constants.mainColor,
                ),
                width: SizeConfig.screenHeight * 0.5121,
                height: SizeConfig.screenHeight * 0.3841,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.05121),
                    Text(
                      employeeLastNameOverall + " " + employeeFirstNameOverall,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05121),
                    Text(
                      employeeIdOverall,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03841),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: SizeConfig.screenHeight * 0.0192),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: Text(
                      "Đăng xuất",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true, //tự tạo nút ra drawer
        backgroundColor: Constants.mainColor,
        //leading: IconButton(
        //icon: Icon(
        //Icons.menu,
        //color: Colors.white,
        //),
        // onPressed: () {},
        //),
        title: Text("Menu"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView( // <>children
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.0384,
            ),
            Text(
              "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            logo,
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            reportButton,
            SizedBox(height: SizeConfig.screenHeight * 0.0192),
            monitorButton,
            SizedBox(height: SizeConfig.screenHeight * 0.12804),
          ],
        ),
      ),
    );
  }
}
