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
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 60.0,
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
