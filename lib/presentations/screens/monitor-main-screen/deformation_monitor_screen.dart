import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/blocs/blocs/defor_monitor_bloc.dart';
import 'package:mobile_app/blocs/events/defor_monitor_event.dart';
import 'package:mobile_app/blocs/states/defor_monitor_state.dart';
import 'package:mobile_app/model/deformation_monitor_data.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/presentations/dialog/dialog.dart';
import 'package:mobile_app/Presentations/widgets/constant.dart';
import 'package:mobile_app/Presentations/widgets/widget.dart';
import 'package:mobile_app/presentations/screens/monitor-main-screen/models/deformations/operating_params_deformation.dart';
import 'package:signalr_core/signalr_core.dart';

class DeformationMonitorScreen extends StatefulWidget {
  @override
  _DeformationMonitorScreenState createState() =>
      new _DeformationMonitorScreenState();
}

class _DeformationMonitorScreenState extends State<DeformationMonitorScreen> {
  int buffer1 = 0;
  int buffer2 = 0;
  int count = 0;
  HubConnection hubConnection;
  String data1 = "null";
  String data2 = "null";
  String data3 = "null";
  String data4 = "null";
  String data5 = "null";
  String data21 = "null";
  String data22 = "null";
  String data23 = "null";
  String data24 = "null";
  String warningMessage = "";
  String warningTitle = "";
  Color modeColor = Colors.black26;
  int mode;
  bool cylinder1 = false;
  bool cylinder2 = false;
  bool cylinder3 = false;
  bool running = false;
  bool warning = false;
  @override
  void initState() {
    super.initState();
    try {
      hubConnection = HubConnectionBuilder()
          .withUrl(Constants.baseUrl + '/hub')
          .withAutomaticReconnect()
          .build();
      hubConnection.keepAliveIntervalInMilliseconds = 10000;
      hubConnection.serverTimeoutInMilliseconds = 10000;
      hubConnection.onclose((error) {
        // print(error);
        return error != null
            ? BlocProvider.of<DeforMonitorBloc>(context).add(
                DeforMonitorEventConnectFail(
                    errorPackage: ErrorPackage(
                        message: "Ngắt kết nối",
                        detail: "Đã ngắt kết nối đến máy chủ!")))
            : null;
      });
      hubConnection.on("MonitorEndurance", monitorEnduranceHandlers);
    } on TimeoutException {
      BlocProvider.of<DeforMonitorBloc>(context).add(
          DeforMonitorEventConnectFail(
              errorPackage: ErrorPackage(
                  message: "Không tìm thấy máy chủ",
                  detail: "Vui lòng kiểm tra đường truyền!")));
    } on SocketException {
      BlocProvider.of<DeforMonitorBloc>(context).add(
          DeforMonitorEventConnectFail(
              errorPackage: ErrorPackage(
                  message: "Không tìm thấy máy chủ",
                  detail: "Vui lòng kiểm tra đường truyền!")));
    } catch (e) {
      BlocProvider.of<DeforMonitorBloc>(context).add(
          DeforMonitorEventConnectFail(
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
            : null;
        return true;
      },
      child: DefaultTabController(
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
            title: Text("Giám sát kiểm tra độ biến dạng"),
          ),
          body: BlocConsumer<DeforMonitorBloc, DeforMonitorState>(
            listener: (context, deforMonitorState) async {
              if (deforMonitorState is Defor12MonitorStateInit) {
                data1 = deforMonitorState.data;
                data2 = deforMonitorState.data;
                data3 = deforMonitorState.data;
                data4 = deforMonitorState.data;
                data5 = deforMonitorState.data;
                data21 = deforMonitorState.data;
                data22 = deforMonitorState.data;
                data23 = deforMonitorState.data;
                data24 = deforMonitorState.data;
                modeColor = Colors.black26;
                warning = false;
                running = false;
                cylinder1 = false;
                cylinder2 = false;
                cylinder3 = false;
              } else if (deforMonitorState
                  is DeforMonitorStateConnectSuccessful) {
                loadingDialog.dismiss();
              } else if (deforMonitorState is DeforMonitorStateDataUpdated) {
                if (count == 0) {
                  count += 1;
                  buffer1 = deforMonitorState.deforMonitorData.errorCode;
                } else if (count == 1) {
                  count = 0;
                  buffer2 = deforMonitorState.deforMonitorData.errorCode;
                }
                switch (deforMonitorState.deforMonitorData.errorCode) {
                  case 0:
                    break;
                  case 100:
                    warningMessage = "Hoàn thành chương trình";
                    warningTitle = "THÔNG BÁO";
                    break;
                  case 500:
                    warningMessage =
                        "Cài đặt lực, thời gian giữ, số lần nhấn và sai số";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 501:
                    warningMessage = "Lực cài đặt hệ 1 quá lớn (>2000)";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 502:
                    warningMessage = "Lực cài đặt hệ 2 quá lớn (>2000)";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 503:
                    warningMessage = "Hệ thống chưa sẵn sàng";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 504:
                    warningMessage = "Lỗi xi lanh 1 chưa tới vị trí đặt lực";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 505:
                    warningMessage = "Lỗi xi lanh 1 chưa về vị trí ban đầu";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 506:
                    warningMessage = "Lỗi xi lanh 2 chưa tới vị trí đặt lực";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 507:
                    warningMessage = "Lỗi xi lanh 2 chưa về vị trí ban đầu";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 508:
                    warningMessage = "Lỗi xi lanh 3 chưa tới vị trí đặt lực";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 509:
                    warningMessage = "Lỗi xi lanh 3 chưa về vị trí ban đầu";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 510:
                    warningMessage = "Dừng hệ thống khẩn cấp";
                    warningTitle = "LỖI XẢY RA";
                    break;
                  case 600:
                    warningMessage = "Xi lanh 1 quá lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  case 601:
                    warningMessage = "Xi lanh 2 quá lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  case 602:
                    warningMessage = "Xi lanh 3 quá lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  case 603:
                    warningMessage = "Xi lanh 1 không đủ lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  case 604:
                    warningMessage = "Xi lanh 2 không đủ lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  case 605:
                    warningMessage = "Xi lanh 3 không đủ lực";
                    warningTitle = "CẢNH BÁO";
                    break;
                  default:
                    break;
                }
                if (deforMonitorState.deforMonitorData.errorCode != 0) {
                  if (buffer1 != buffer2) {
                    AlertDialogOneBtnCustomized(
                            context: context,
                            title: warningTitle,
                            desc: warningMessage,
                            textBtn: "OK")
                        .show();
                  }
                }
                data1 = deforMonitorState.deforMonitorData.forceCylinderSp12
                    .toString();
                data2 =
                    deforMonitorState.deforMonitorData.timeHoldSp12.toString();
                data3 =
                    deforMonitorState.deforMonitorData.noPressSp12.toString();
                data4 =
                    deforMonitorState.deforMonitorData.noPressPv1.toString();
                data5 =
                    deforMonitorState.deforMonitorData.noPressPv2.toString();
                data21 = deforMonitorState.deforMonitorData.forceCylinderSp3
                    .toString();
                data22 =
                    deforMonitorState.deforMonitorData.timeHoldSp3.toString();
                data23 =
                    deforMonitorState.deforMonitorData.noPressSp3.toString();
                data24 =
                    deforMonitorState.deforMonitorData.noPressPv3.toString();
                running = deforMonitorState.deforMonitorData.greenStatus;
                warning = deforMonitorState.deforMonitorData.redStatus;
                cylinder1 = deforMonitorState.deforMonitorData.seclect1;
                cylinder2 = deforMonitorState.deforMonitorData.seclect1;
                cylinder3 = deforMonitorState.deforMonitorData.seclect2;
                switch (deforMonitorState.deforMonitorData.modeStatus) {
                  case 0:
                    modeColor = Colors.brown[500];
                    break;
                  case 1:
                    modeColor = Colors.blue;
                    break;
                  case 2:
                    modeColor = Color(0xff02692e);
                    break;
                  default:
                    modeColor = Colors.black26;
                }
              } else if (deforMonitorState is DeforMonitorStateConnectFail) {
                print(hubConnection.state.toString());
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: deforMonitorState.errorPackage.message,
                        desc: deforMonitorState.errorPackage.detail)
                    .show();
              } else if (deforMonitorState
                  is Defor12MonitorStateLoadingRequest) {
                loadingDialog.show();
              }
            },
            builder: (context, deforMonitorState) => TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'THÔNG SỐ VẬN HÀNH',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          CustomizedButton(
                            fontSize: 25,
                            width: SizeConfig.screenWidth * 0.5121,
                            height: SizeConfig.screenHeight * 0.05121,
                            onPressed: () {
                              BlocProvider.of<DeforMonitorBloc>(context).add(
                                  DeforMonitorEventHubConnected(
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
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            width: SizeConfig.screenWidth * 0.8962,
                            height: SizeConfig.screenHeight * 0.2561,
                            child: MonitorOperatingParamsDefor1(
                              text1: "Lực nén cài đặt",
                              text2: "Thời gian giữ",
                              text3: "Số lần cài đặt",
                              text4: "Số lần hiện tại",
                              data1: data1,
                              data2: data2,
                              data3: data3,
                              colorText1: cylinder1 ? Colors.green : null,
                              colorText2: cylinder2 ? Colors.green : null,
                              data4: data4, //xilanh 1
                              data5: data5, //xilanh 2
                            ),
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
                                      decoration: new BoxDecoration(
                                        color: modeColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "CHẾ ĐỘ",
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bảng chú thích mã màu",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Colors.brown[500]),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Tạm dừng",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 15),
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Thủ công",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 15),
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Color(0xff02692e)),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Tự động",
                                  style: TextStyle(
                                    fontSize: 17,
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
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'THÔNG SỐ VẬN HÀNH',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.0128),
                          CustomizedButton(
                            fontSize: 25,
                            width: SizeConfig.screenWidth * 0.5121,
                            height: SizeConfig.screenHeight * 0.05121,
                            onPressed: () {
                              BlocProvider.of<DeforMonitorBloc>(context).add(
                                  DeforMonitorEventHubConnected(
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
                            child: MonitorOperatingParamsDefor(
                              text1: "Lực nén cài đặt",
                              text2: "Thời gian giữ",
                              text3: "Số lần cài đặt",
                              text4: "Số lần hiện tại",
                              data1: data21,
                              data2: data22,
                              data3: data23,
                              data4: data24,
                              colorText1: cylinder3 ? Colors.green : null,
                            ),
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
                                      decoration: new BoxDecoration(
                                        color: modeColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      "CHẾ ĐỘ",
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
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
                                      width: SizeConfig.screenHeight * 0.1024,
                                      height: SizeConfig.screenHeight * 0.1024,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bảng chú thích mã màu",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Colors.brown[500]),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Tạm dừng",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 15),
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Thủ công",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 15),
                                ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Color(0xff02692e)),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Tự động",
                                  style: TextStyle(
                                    fontSize: 17,
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
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  void monitorEnduranceHandlers(List<dynamic> data) {
    BlocProvider.of<DeforMonitorBloc>(context).add(DeforMonitorEventDataUpdated(
        deforMonitorData: DeforMonitorData(
      noPressPv1: Map<String, dynamic>.from(data[0])["numberOfTestPv1"],
      noPressPv2: Map<String, dynamic>.from(data[0])["numberOfTestPv2"],
      noPressPv3: Map<String, dynamic>.from(data[0])["numberOfTestPv3"],
      noPressSp12: Map<String, dynamic>.from(data[0])["numberOfTestSp12"],
      noPressSp3: Map<String, dynamic>.from(data[0])["numberOfTestSp3"],
      errorCode: Map<String, dynamic>.from(data[0])["errorCode"],
      modeStatus: Map<String, dynamic>.from(data[0])["modeStatus"],
      forceCylinderSp12:
          Map<String, dynamic>.from(data[0])["forceCylinderSp12"].toString(),
      forceCylinderSp3:
          Map<String, dynamic>.from(data[0])["forceCylinderSp3"].toString(),
      timeHoldSp12:
          Map<String, dynamic>.from(data[0])["timeHoldSp12"].toString(),
      timeHoldSp3: Map<String, dynamic>.from(data[0])["timeHoldSp3"].toString(),
      seclect1: Map<String, dynamic>.from(data[0])["seclect1"],
      seclect2: Map<String, dynamic>.from(data[0])["seclect2"],
      redStatus: Map<String, dynamic>.from(data[0])["redStatus"],
      errorStatus: Map<String, dynamic>.from(data[0])["errorStatus"],
      greenStatus: Map<String, dynamic>.from(data[0])["greenStatus"],
    )));
  }
}
