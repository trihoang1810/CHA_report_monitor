import 'package:flutter/material.dart';

//HỆ 2
class MonitorOperatingParamsDefor extends StatefulWidget {
  String text1;
  String text2;
  String text3;

  String data1 = "";
  String data2 = "";
  String data3 = "";

  MonitorOperatingParamsDefor({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.data1,
    @required this.data2,
    @required this.data3,
  }) : super(key: key);
  @override
  _MonitorOperatingParamsDeforState createState() =>
      new _MonitorOperatingParamsDeforState();
}

class _MonitorOperatingParamsDeforState
    extends State<MonitorOperatingParamsDefor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(),
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
          ],
        ),
        SizedBox(width: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "XI LANH 3",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data1)),
            ),
            Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data2)),
            ),
            Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data3)),
            ),
          ],
        ),
      ],
    );
  }
}

//HỆ 1
class MonitorOperatingParamsDefor1 extends StatefulWidget {
  String text1;
  String text2;
  String text3;

  String data1 = "";
  String data2 = "";
  String data3 = "";
  String data4 = "";
  String data5 = "";
  String data6 = "";

  MonitorOperatingParamsDefor1({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.data1,
    @required this.data2,
    @required this.data3,
    @required this.data4,
    @required this.data5,
    @required this.data6,
  }) : super(key: key);
  @override
  _MonitorOperatingParamsDefor1State createState() =>
      new _MonitorOperatingParamsDefor1State();
}

class _MonitorOperatingParamsDefor1State
    extends State<MonitorOperatingParamsDefor1> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(),
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
          ],
        ),
        SizedBox(width: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "XI LANH 1",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data1)),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data2)),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data3)),
            ),
          ],
        ),
        SizedBox(width: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "XI LANH 2",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data4)),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data5)),
            ),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data6)),
            ),
          ],
        ),
      ],
    );
  }
}
