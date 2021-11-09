import 'package:flutter/material.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';
import 'package:mobile_app/presentations/widgets/main_app_name.dart';

class MonitorModeScreen extends StatefulWidget {
  @override
  _MonitorModeScreenState createState() => new _MonitorModeScreenState();
}

class _MonitorModeScreenState extends State<MonitorModeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Giám sát"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.mainColor,
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
            MainAppName(text: 'GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM'),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1024,
            ),
            CustomizedButton(
              text: "Độ bền",
              onPressed: () {
                Navigator.pushNamed(context, '/reliabilitymonitorscreen');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.0192),
            CustomizedButton(
              text: 'Độ biến dạng',
              onPressed: () {
                Navigator.pushNamed(context, '/deformationmonitorscreen');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.128),
          ],
        ),
      ),
    );
  }
}
