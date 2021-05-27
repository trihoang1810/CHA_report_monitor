import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Screens/MonitorMainScreen/Model/Reliability/operating_params_reliability.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/reli_monitor_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';

class ReliabilityMonitorScreen extends StatefulWidget {
  @override
  _ReliabilityMonitorScreenState createState() =>
      new _ReliabilityMonitorScreenState();
}

class _ReliabilityMonitorScreenState extends State<ReliabilityMonitorScreen> {
  String data1 = "null";
  String data2 = "null";
  String data3 = "null";
  String data4 = "null";
  String data21 = "null";
  String data22 = "null";
  String data23 = "null";
  String data24 = "null";
  bool warning = false;
  bool running = false;
  bool warning2 = false;
  bool running2 = false;
  @override
  Widget build(BuildContext context) {
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => ReliMonitorBloc(),
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
          body: BlocConsumer<ReliMonitorBloc, ReliMonitorState>(
            listener: (context, reliMonitorState) async {
              if (reliMonitorState is ReliMonitorStateInit) {
                data1 = reliMonitorState.data1;
                data2 = reliMonitorState.data2;
                data3 = reliMonitorState.data3;
                data4 = reliMonitorState.data4;
                running = false;
                warning = false;
              } else if (reliMonitorState is ReliMonitorStateLoadingRequest) {
                loadingDialog.show();
              } else if (reliMonitorState
                  is ReliMonitorStateLoadingSuccessful) {
                loadingDialog.dismiss();
                data1 = reliMonitorState.reliMonitorData.close;
                data2 = reliMonitorState.reliMonitorData.open;
                data3 = reliMonitorState.reliMonitorData.welcomeSet.toString();
                data4 = reliMonitorState.reliMonitorData.moment.toString();
                running = reliMonitorState.reliMonitorData.running;
                warning = reliMonitorState.reliMonitorData.warning;
              } else if (reliMonitorState is ReliMonitorStateLoadingFailure) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: "Truy xuất thất bại",
                        desc: "Vui lòng thử lại",
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (reliMonitorState is ReliCBMonitorStateLoadingRequest) {
                loadingDialog.show();
              } else if (reliMonitorState
                  is ReliCBMonitorStateLoadingSuccessful) {
                loadingDialog.dismiss();
                data21 = reliMonitorState.reliCBMonitorData.close;
                data22 = reliMonitorState.reliCBMonitorData.open;
                data23 =
                    reliMonitorState.reliCBMonitorData.welcomeSet.toString();
                data24 = reliMonitorState.reliCBMonitorData.moment.toString();
                running2 = reliMonitorState.reliCBMonitorData.running;
                warning2 = reliMonitorState.reliCBMonitorData.warning;
              } else if (reliMonitorState is ReliCBMonitorStateLoadingFailure) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: "Truy xuất thất bại",
                        desc: "Vui lòng thử lại",
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              }
            },
            builder: (context, reliMonitorState) => TabBarView(
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
                        onPressed: () {
                          BlocProvider.of<ReliMonitorBloc>(context)
                              .add(ReliMonitorEventSearchingClicked());
                        },
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
                            data1: data1,
                            data2: data2,
                            data3: data3,
                            data4: data4),
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
                                    color:
                                        running ? Colors.green : Colors.black26,
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
                                    color:
                                        warning ? Colors.red : Colors.black26,
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
                        onPressed: () {
                          BlocProvider.of<ReliMonitorBloc>(context)
                              .add(ReliCBMonitorEventSearchingClicked());
                        },
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
                            data1: data21,
                            data2: data22,
                            data3: data23,
                            data4: data24),
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
                                    color: running2
                                        ? Colors.green
                                        : Colors.black26,
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
                                    color:
                                        warning2 ? Colors.red : Colors.black26,
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
        ),
      ),
    );
  }
}
