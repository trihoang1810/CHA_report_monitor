import 'package:flutter/material.dart';

//HỆ 2
class MonitorOperatingParamsDefor extends StatefulWidget {
  String text1;
  String text2;
  String text3;
  String text4;
  Color colorText1;

  String data1 = "";
  String data2 = "";
  String data3 = "";
  String data4 = "";
 

  MonitorOperatingParamsDefor({
    Key key,
  
    @required this.data4,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.text4,
    @required this.data1,
    @required this.data2,
    @required this.data3,
  
    @required this.colorText1,
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
            Text(
              widget.text4,
              //"Thời gian đóng nắp cầu",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        SizedBox(width: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.colorText1,
                border: Border.all(),
              ),
              child: Text(
                "XI LANH 3",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
            Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data4)),
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
  String text4;
  Color colorText1;
  Color colorText2;
  String data1 = "";
  String data2 = "";
  String data3 = "";
  String data4 = "";
   String data5 = "";
  MonitorOperatingParamsDefor1(
      {Key key,
      @required this.text1,
      @required this.text2,
      @required this.text3,
      @required this.text4,
      @required this.data1,
      @required this.data2,
      @required this.data3,
      @required this.data4,
      @required this.data5,
      @required this.colorText1,
      @required this.colorText2})
      : super(key: key);
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
            Text(
              widget.text4,
              //"Số lần đóng NBC",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        SizedBox(width: 35),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: widget.colorText1,
                    border: Border.all(),
                  ),
                  child: Text(
                    "XI LANH 1",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                    color: widget.colorText2,
                    border: Border.all(),
                  ),
                  child: Text(
                    "XI LANH 2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              width: 180,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data1)),
            ),
            Container(
              width: 180,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data2)),
            ),
            Container(
              width: 180,
              height: 30,
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Text(widget.data3)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(color: Colors.black26),
                  child: Center(child: Text(widget.data4)),
                ),
                SizedBox(width: 20),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(color: Colors.black26),
                  child: Center(child: Text(widget.data5)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
