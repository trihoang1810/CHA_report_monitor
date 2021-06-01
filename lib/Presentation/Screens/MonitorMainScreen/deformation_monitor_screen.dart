import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/screens/monitormainscreen/model/deformation/operating_params_deformation.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class DeformationMonitorScreen extends StatefulWidget {
  @override
  _DeformationMonitorScreenState createState() =>
      new _DeformationMonitorScreenState();
}

class _DeformationMonitorScreenState extends State<DeformationMonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Hệ 1"),
              Tab(text: "Hệ 2"),
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
          title: Text("Giám sát kiểm tra độ biến dạng"),
        ),
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
                    textAlign: TextAlign.center,
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
                    child: MonitorOperatingParamsDefor1(
                      text1: "Lực nén cài đặt",
                      text2: "Thời gian giữ",
                      text3: "Số lần cài đặt",
                      text4: "Số lần hiện tại",
                      data1: "123",
                      data2: "456",
                      data3: "789",
                      color1: Colors.green,
                      color2: Colors.green,
                    ),
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
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "CHẾ ĐỘ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
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
                              width: 80.0,
                              height: 80.0,
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
                    textAlign: TextAlign.center,
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
                    child: MonitorOperatingParamsDefor(
                      text1: "Lực nén cài đặt",
                      text2: "Thời gian giữ",
                      text3: "Số lần cài đặt",
                      text4: "Số lần hiện tại",
                      data1: "123",
                      data2: "456",
                      data3: "789",
                      color: Colors.green,
                    ),
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
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "CHẾ ĐỘ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
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
                              width: 80.0,
                              height: 80.0,
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
        backgroundColor: Colors.white,
      ),
    );
  }
}
