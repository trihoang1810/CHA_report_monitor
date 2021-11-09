import 'package:flutter/material.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';
import 'package:mobile_app/presentations/widgets/main_app_name.dart';

class ReportModeScreen extends StatefulWidget {
  @override
  _ReportModeScreenState createState() => new _ReportModeScreenState();
}

class _ReportModeScreenState extends State<ReportModeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo"),
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

            MainAppName(text: "BÁO CÁO KIỂM TRA CHẤT LƯỢNG SẢN PHẨM"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1024,
            ),
            CustomizedButton(
              text: 'Độ bền',
              onPressed: () {
                Navigator.pushNamed(context, '/reliabilityreportscreen');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.0192),
            CustomizedButton(
              text: 'Độ biến dạng',
              onPressed: () {
                Navigator.pushNamed(context, '/deformationreportscreen');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.128),
          ],
        ),
      ),
    );
  }
}
