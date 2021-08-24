import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Screens/MonitorMainScreen/Model/Reliability/operating_params_reliability.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/reli_monitor_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';
import 'package:signalr_core/signalr_core.dart';

class ReliabilityMonitorScreen extends StatefulWidget {
  ReliabilityMonitorScreen({Key key}) : super(key: key);
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
  HubConnection hubConnection;
  @override
  void initState() {
    super.initState();
    try {
      hubConnection = HubConnectionBuilder()
          .withUrl(Constants.baseUrl + '/hub')
          .withAutomaticReconnect()
          .build();
      hubConnection.keepAliveIntervalInMilliseconds = 30000;
      hubConnection.serverTimeoutInMilliseconds = 30000;
      hubConnection.onclose((error) {
        return BlocProvider.of<ReliMonitorBloc>(context).add(
            ReliMonitorEventConnectFail(
                errorPackage: ErrorPackage(
                    message: "Không tìm thấy máy chủ",
                    detail: "Vui lòng kiểm tra đường truyền!")));
      });
      hubConnection.on("MonitorReliability", monitorReliabilityHandlers);
      hubConnection.on("MonitorDeformation", monitorDeformationHandlers);
    } on TimeoutException {
      BlocProvider.of<ReliMonitorBloc>(context).add(ReliMonitorEventConnectFail(
          errorPackage: ErrorPackage(
              message: "Không tìm thấy máy chủ",
              detail: "Vui lòng kiểm tra đường truyền!")));
    } on SocketException {
      BlocProvider.of<ReliMonitorBloc>(context).add(ReliMonitorEventConnectFail(
          errorPackage: ErrorPackage(
              message: "Không tìm thấy máy chủ",
              detail: "Vui lòng kiểm tra đường truyền!")));
    } catch (e) {
      BlocProvider.of<ReliMonitorBloc>(context).add(ReliMonitorEventConnectFail(
          errorPackage:
              ErrorPackage(message: "Lỗi xảy ra", detail: e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return WillPopScope(
      onWillPop: () async {
        AlertDialogTwoBtnCustomized alertDialogOneBtnCustomized =
            AlertDialogTwoBtnCustomized(
                context: context,
                title: "Bạn có muốn?",
                desc: "Ứng dụng sẽ tự ngắt kết nối với máy chủ",
                textBtn1: "Có",
                textBtn2: "Quay lại",
                onPressedBtn1: () {
                  Navigator.pop(context);
                });
        hubConnection.state == HubConnectionState.connected
            ? alertDialogOneBtnCustomized.show()
            : print("adu");
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Độ bền êm"),
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
                AlertDialogTwoBtnCustomized alertDialogOneBtnCustomized =
                    AlertDialogTwoBtnCustomized(
                        context: context,
                        title: "Bạn có muốn?",
                        desc: "Ứng dụng sẽ tự ngắt kết nối với máy chủ",
                        textBtn1: "Có",
                        textBtn2: "Quay lại",
                        onPressedBtn1: () {
                          Navigator.pop(context);
                        });
                hubConnection.state == HubConnectionState.connected
                    ? alertDialogOneBtnCustomized.show()
                    : Navigator.pop(context);
              },
            ),
            title: Text("Giám sát kiểm tra độ bền"),
          ),
          backgroundColor: Colors.white,
          body: BlocConsumer<ReliMonitorBloc, ReliMonitorState>(
            listener: (context, reliMonitorState) async {
              if (reliMonitorState is ReliMonitorStateConnectFail) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: reliMonitorState.errorPackage.message,
                        desc: reliMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (reliMonitorState is ReliMonitorStateConnectSucessful) {
                loadingDialog.dismiss();
                data1 = reliMonitorState.reliMonitorData.soLanDongNapCaiDat
                    .toString();
                data2 = reliMonitorState.reliMonitorData.soLanDongNapHienTai
                    .toString();
                data3 = reliMonitorState.reliMonitorData.thoiGianGiuNapDong
                    .toString();
                data4 = reliMonitorState.reliMonitorData.thoiGianGiuNapMo
                    .toString();
                warning = reliMonitorState.reliMonitorData.alarm;
                running = reliMonitorState.reliMonitorData.running;

                print(hubConnection.state.toString());
              } else if (reliMonitorState is ReliMonitorStateDataUpdated) {
                loadingDialog.dismiss();
                print('chụp được state nè');
                data1 = reliMonitorState.reliMonitorData.soLanDongNapCaiDat
                    .toString();
                data2 = reliMonitorState.reliMonitorData.soLanDongNapHienTai
                    .toString();
                data3 = reliMonitorState.reliMonitorData.thoiGianGiuNapDong
                    .toString();
                data4 = reliMonitorState.reliMonitorData.thoiGianGiuNapMo
                    .toString();
                warning = reliMonitorState.reliMonitorData.alarm;
                running = reliMonitorState.reliMonitorData.running;
              } else if (reliMonitorState is ReliMonitorStateLoadingRequest) {
                loadingDialog.show();
              } else if (reliMonitorState is ReliCBMonitorStateLoadingRequest) {
                loadingDialog.show();
              }
              if (reliMonitorState is ReliCBMonitorStateConnectFail) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: reliMonitorState.errorPackage.message,
                        desc: reliMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (reliMonitorState
                  is ReliCBMonitorStateConnectSucessful) {
                loadingDialog.dismiss();
                data21 = reliMonitorState.reliCBMonitorData.soLanDongNapCaiDat
                    .toString();
                data22 = reliMonitorState.reliCBMonitorData.soLanDongNapHienTai
                    .toString();
                data23 = reliMonitorState.reliCBMonitorData.thoiGianGiuNapDong
                    .toString();
                data24 = reliMonitorState.reliCBMonitorData.thoiGianGiuNapMo
                    .toString();
                warning2 = reliMonitorState.reliCBMonitorData.alarm;
                running2 = reliMonitorState.reliCBMonitorData.running;
                print(hubConnection.state.toString());
              } else if (reliMonitorState is ReliCBMonitorStateDataUpdated) {
                loadingDialog.dismiss();
                print('chụp được state nè');
                data21 = reliMonitorState.reliCBMonitorData.soLanDongNapCaiDat
                    .toString();
                data22 = reliMonitorState.reliCBMonitorData.soLanDongNapHienTai
                    .toString();
                data23 = reliMonitorState.reliCBMonitorData.thoiGianGiuNapDong
                    .toString();
                data24 = reliMonitorState.reliCBMonitorData.thoiGianGiuNapMo
                    .toString();
                warning2 = reliMonitorState.reliCBMonitorData.alarm;
                running2 = reliMonitorState.reliCBMonitorData.running;
              }
            },
            builder: (context, reliMonitorState) => WillPopScope(
              onWillPop: () async {
                return hubConnection.state == HubConnectionState.connected
                    ? false
                    : true;
              },
              child: TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Center(
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
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          CustomizedButton(
                            fontSize: 25,
                            width: SizeConfig.screenWidth * 0.5121,
                            height: SizeConfig.screenHeight * 0.05121,
                            onPressed: () {
                              // BlocProvider.of<ReliMonitorBloc>(context)
                              //     .add(ReliMonitorEventSearchingClicked());
                              BlocProvider.of<ReliMonitorBloc>(context).add(
                                  ReliMonitorEventHubConnected(
                                      hubConnection: hubConnection));
                            },
                            text: "Truy xuất",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                hubConnection.state ==
                                        HubConnectionState.connected
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                color: hubConnection.state ==
                                        HubConnectionState.connected
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                hubConnection.state ==
                                        HubConnectionState.connected
                                    ? "Đã kết nối"
                                    : "Ngắt kết nối",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: hubConnection.state ==
                                            HubConnectionState.connected
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: SizeConfig.screenWidth * 0.8962,
                            height: SizeConfig.screenHeight * 0.2561,
                            child: MonitorOperatingParamsReli(
                                text1: "Số lần đóng nắp cài đặt",
                                text2: "Số lần đóng nắp hiện tại",
                                text3: "Thời gian đóng nắp cầu",
                                text4: "Thời gian mở nắp cầu",
                                data1: data1,
                                data2: data2,
                                data3: data3,
                                data4: data4),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0256),
                          Text(
                            'BẢNG GIÁM SÁT',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0256),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: SizeConfig.screenWidth * 0.8962,
                            height: SizeConfig.screenHeight * 0.2176,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenHeight * 0.1280,
                                      height: SizeConfig.screenHeight * 0.1280,
                                      decoration: new BoxDecoration(
                                        color: running
                                            ? Colors.green
                                            : Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "ĐANG CHẠY",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenHeight * 0.1280,
                                      height: SizeConfig.screenHeight * 0.1280,
                                      decoration: new BoxDecoration(
                                        color: warning
                                            ? Colors.red
                                            : Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "CẢNH BÁO",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.03841),
                          Text(
                            'THÔNG SỐ VẬN HÀNH',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          CustomizedButton(
                            fontSize: 25,
                            width: SizeConfig.screenWidth * 0.5121,
                            height: SizeConfig.screenHeight * 0.05121,
                            onPressed: () {
                              BlocProvider.of<ReliMonitorBloc>(context).add(
                                  ReliCBMonitorEventHubConnected(
                                      hubConnection: hubConnection));
                            },
                            text: "Truy xuất",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                hubConnection.state ==
                                        HubConnectionState.connected
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                color: hubConnection.state ==
                                        HubConnectionState.connected
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                hubConnection.state ==
                                        HubConnectionState.connected
                                    ? "Đã kết nối"
                                    : "Ngắt kết nối",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: hubConnection.state ==
                                            HubConnectionState.connected
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: SizeConfig.screenWidth * 0.8962,
                            height: SizeConfig.screenHeight * 0.2561,
                            child: MonitorOperatingParamsReli(
                                text1: "Số lần đóng nắp cài đặt",
                                text2: "Số lần đóng nắp hiện tại",
                                text3: "Thời gian đóng nắp cầu",
                                text4: "Thời gian mở nắp cầu",
                                data1: data21,
                                data2: data22,
                                data3: data23,
                                data4: data24),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0256),
                          Text(
                            'BẢNG GIÁM SÁT',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0256),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: SizeConfig.screenWidth * 0.8962,
                            height: SizeConfig.screenHeight * 0.2176,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenHeight * 0.1280,
                                      height: SizeConfig.screenHeight * 0.1280,
                                      decoration: new BoxDecoration(
                                        color: running2
                                            ? Colors.green
                                            : Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "ĐANG CHẠY",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenHeight * 0.1280,
                                      height: SizeConfig.screenHeight * 0.1280,
                                      decoration: new BoxDecoration(
                                        color: warning2
                                            ? Colors.red
                                            : Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "CẢNH BÁO",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void monitorReliabilityHandlers(List<dynamic> data) {
    BlocProvider.of<ReliMonitorBloc>(context).add(ReliMonitorEventDataUpdated(
        reliMonitorData: ReliMonitorData(
            alarm: Map<String, dynamic>.from(data[0])["alarm"],
            running: Map<String, dynamic>.from(data[0])["running"],
            thoiGianGiuNapDong:
                Map<String, dynamic>.from(data[0])["timeLidClose"],
            thoiGianGiuNapMo: Map<String, dynamic>.from(data[0])["timeLidOpen"],
            soLanDongNapCaiDat:
                Map<String, dynamic>.from(data[0])["numberClosingSp"],
            soLanDongNapHienTai:
                Map<String, dynamic>.from(data[0])["numberClosingPv"])));
  }

  void monitorDeformationHandlers(List<dynamic> data) {
    print('Hứng dữ liệu');
    BlocProvider.of<ReliMonitorBloc>(context).add(ReliCBMonitorEventDataUpdated(
        reliCBMonitorData: ReliCBMonitorData(
            alarm: Map<String, dynamic>.from(data[0])["alarm"],
            running: Map<String, dynamic>.from(data[0])["running"],
            thoiGianGiuNapDong:
                Map<String, dynamic>.from(data[0])["timeLidClose"],
            thoiGianGiuNapMo: Map<String, dynamic>.from(data[0])["timeLidOpen"],
            soLanDongNapCaiDat:
                Map<String, dynamic>.from(data[0])["numberClosingSp"],
            soLanDongNapHienTai:
                Map<String, dynamic>.from(data[0])["numberClosingPv"])));
  }
}
