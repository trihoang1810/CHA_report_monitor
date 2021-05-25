import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Screens/MonitorMainScreen/Model/Reliability/operating_params_reliability.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class ReliabilityMonitorScreen extends StatefulWidget {
  @override
  _ReliabilityMonitorScreenState createState() =>
      new _ReliabilityMonitorScreenState();
}

class _ReliabilityMonitorScreenState extends State<ReliabilityMonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Độ bền"),
              Tab(text: "Độ bền CB"),
            ],
          ),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Giám sát kiểm tra độ bền"),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    'THÔNG SỐ VẬN HÀNH',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomizedButton(
                    fontSize: 25,
                    width: 200,
                    height: 40,
                    onPressed: () {},
                    text: "Truy xuất",
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 350,
                    height: 200,
                    child: MonitorOperatingParamsReli(
                        text1: "Thời gian đóng nắp cầu",
                        text2: "Thời gian mở nắp cầu",
                        text3: "Số lần đóng nắp cài đặt",
                        text4: "Số lần đóng nắp hiện tại",
                        data1: "123",
                        data2: "456",
                        data3: "789",
                        data4: "357"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'BẢNG GIÁM SÁT',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 350,
                    height: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "ĐANG CHẠY",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "CẢNH BÁO",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    'THÔNG SỐ VẬN HÀNH',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomizedButton(
                    fontSize: 25,
                    width: 200,
                    height: 40,
                    onPressed: () {},
                    text: "Truy xuất",
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 350,
                    height: 200,
                    child: MonitorOperatingParamsReli(
                        text1: "Thời gian dừng lên",
                        text2: "Thời gian dừng xuống",
                        text3: "Số lần đóng nắp cài đặt",
                        text4: "Số lần đóng nắp hiện tại",
                        data1: "123",
                        data2: "456",
                        data3: "789",
                        data4: "357"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'BẢNG GIÁM SÁT',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 350,
                    height: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "ĐANG CHẠY",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "CẢNH BÁO",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
