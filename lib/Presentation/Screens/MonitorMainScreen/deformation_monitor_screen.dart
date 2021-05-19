import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';

class DeformationMonitorScreen extends StatefulWidget {
  @override
  _DeformationMonitorScreenState createState() =>
      new _DeformationMonitorScreenState();
}

class _DeformationMonitorScreenState extends State<DeformationMonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
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
                  children: <Widget>[],
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
