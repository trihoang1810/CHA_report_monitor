import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';

class DeformationReportScreen extends StatefulWidget {
  @override
  _DeformationReportScreenState createState() =>
      new _DeformationReportScreenState();
}

class _DeformationReportScreenState extends State<DeformationReportScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Chịu va đập"),
                Tab(text: "Chịu lực uốn"),
                Tab(text: "Rock Start"),
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
            title: Text("Báo cáo kiểm tra độ biến dạng"),
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
