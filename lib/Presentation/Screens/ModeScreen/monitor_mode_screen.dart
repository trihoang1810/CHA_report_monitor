import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class MonitorModeScreen extends StatefulWidget {
  @override
  _MonitorModeScreenState createState() => new _MonitorModeScreenState();
}

class _MonitorModeScreenState extends State<MonitorModeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final reportButton = new CustomizedButton(
      text: "Độ bền",
      onPressed: () {
        Navigator.pushNamed(context, '/reliabilitymonitorscreen');
      },
    );
    final reportButtonCB = new CustomizedButton(
      text: 'Độ biến dạng',
      onPressed: () {
        Navigator.pushNamed(context, '/deformationmonitorscreen');
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.mainColor,
        //leading: IconButton(
        //icon: Icon(
        //Icons.menu,
        //color: Colors.white,
        //),
        // onPressed: () {},
        //),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.0611,
              right: SizeConfig.screenWidth * 0.0611),
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.0384,
            ),
            Text(
              "GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1024,
            ),
            reportButton,
            SizedBox(height: SizeConfig.screenHeight * 0.0192),
            reportButtonCB,
            SizedBox(height: SizeConfig.screenHeight * 0.128),
          ],
        ),
      ),
    );
  }
}
