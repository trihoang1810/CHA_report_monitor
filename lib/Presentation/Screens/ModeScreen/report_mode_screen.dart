import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class ReportModeScreen extends StatefulWidget {
  @override
  _ReportModeScreenState createState() => new _ReportModeScreenState();
}

class _ReportModeScreenState extends State<ReportModeScreen> {
  @override
  Widget build(BuildContext context) {
    final reportButton = new CustomizedButton(
      text: 'ĐỘ BỀN',
      onPressed: () {
        Navigator.pushNamed(context, '/reliabilityreportscreen');
      },
    );
    final reportButtonCB = new CustomizedButton(
      text: 'ĐỘ BIẾN DẠNG',
      onPressed: () {
        Navigator.pushNamed(context, '/deformationreportscreen');
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
              "BÁO CÁO KIỂM TRA CHẤT LƯỢNG SẢN PHẨM NẮP BỒN CẦU",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 80.0,
            ),
            reportButton,
            SizedBox(height: 15.0),
            reportButtonCB,
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
