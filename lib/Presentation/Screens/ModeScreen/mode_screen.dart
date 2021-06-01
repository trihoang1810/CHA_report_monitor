import 'package:flutter/material.dart';
import 'package:mobile_app/models/func.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

// ignore: must_be_immutable
class ModeScreen extends StatefulWidget {
  @override
  _ModeScreenState createState() => new _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  Widget build(BuildContext context) {
    final logo =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Image.asset(
        'lib/assets/CHAlogo.png',
        width: 120,
      ),
      SizedBox(width: 30),
      Image.asset(
        'lib/assets/BK_VIAMLAB.png',
        width: 120,
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
                width: 400,
                height: 300,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      employeeLastNameOverall + " " + employeeFirstNameOverall,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      employeeIdOverall,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 15),
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
        automaticallyImplyLeading: true,
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
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM NẮP BỒN CẦU",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(height: 40),
            logo,
            SizedBox(
              height: 80.0,
            ),
            reportButton,
            SizedBox(height: 15.0),
            monitorButton,
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
