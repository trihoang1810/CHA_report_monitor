import 'package:flutter/material.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';

class MonitorOperatingParamsReli extends StatefulWidget {
  String text1;
  String text2;
  String text3;
  String text4;
  String data1 = "";
  String data2 = "";
  String data3 = "";
  String data4 = "";
  MonitorOperatingParamsReli({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.text4,
    @required this.data1,
    @required this.data2,
    @required this.data3,
    @required this.data4,
  }) : super(key: key);
  @override
  _MonitorOperatingParamsReliState createState() =>
      new _MonitorOperatingParamsReliState();
}

class _MonitorOperatingParamsReliState
    extends State<MonitorOperatingParamsReli> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.text1,
              //"Thời gian đóng nắp cầu",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(
              widget.text2,
              //"Thời gian mở nắp cầu",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(
              widget.text3,
              //"Số lần đóng NBC",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(
              widget.text4,
              //"Thời gian đóng êm",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.08962),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.3841,
              height: SizeConfig.screenHeight * 0.03841,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data1)),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.3841,
              height: SizeConfig.screenHeight * 0.03841,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data2)),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.3841,
              height: SizeConfig.screenHeight * 0.03841,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data3)),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.3841,
              height: SizeConfig.screenHeight * 0.03841,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data4)),
            ),
          ],
        ),
      ],
    );
  }
}
