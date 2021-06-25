import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/blocs/defor_monitor_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_monitor_event.dart';
import 'package:mobile_app/business_logic/states/defor_monitor_state.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';
import 'package:mobile_app/presentation/screens/monitormainscreen/model/deformation/operating_params_deformation.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class DeformationMonitorScreen extends StatefulWidget {
  @override
  _DeformationMonitorScreenState createState() =>
      new _DeformationMonitorScreenState();
}

class _DeformationMonitorScreenState extends State<DeformationMonitorScreen> {
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
  Color modeColor;
  int mode;
  bool cylinder1 = false;
  bool cylinder2 = false;
  bool cylinder3 = false;
  bool running = false;
  bool warning = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => DeforMonitorBloc(),
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
                BlocProvider.of<DeforMonitorBloc>(context)
                    .add(Defor1MonitorEventCancelRefetchData());
              },
            ),
            title: Text("Giám sát kiểm tra độ biến dạng"),
          ),
          body: BlocConsumer<DeforMonitorBloc, DeforMonitorState>(
            listener: (context, deforMonitorState) async {
              if (deforMonitorState is Defor12MonitorStateInit) {
                data1 = deforMonitorState.data1;
                data2 = deforMonitorState.data2;
                data3 = deforMonitorState.data3;
                data4 = deforMonitorState.data4;
                data5 = deforMonitorState.data4;
                modeColor = Colors.black26;
                warning = false;
                running = false;
              } else if (deforMonitorState
                  is Defor12MonitorStateLoadingRequest) {
                loadingDialog.show();
              } else if (deforMonitorState
                  is Defor12MonitorStateLoadingSuccessful) {
                loadingDialog.dismiss();
                switch (deforMonitorState.deforMonitorData.errorCode) {
                  case 0:
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
                  AlertDialogOneBtnCustomized(
                          context: context,
                          title: warningTitle,
                          desc: warningMessage,
                          textBtn: "OK")
                      .show();
                }
                data1 = deforMonitorState.deforMonitorData.forceCylinderSp12
                    .toString();
                data3 =
                    deforMonitorState.deforMonitorData.noPressSp12.toString();
                data2 =
                    deforMonitorState.deforMonitorData.timeHoldSp12.toString();
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
                    modeColor = Colors.black26;
                    break;
                  case 1:
                    modeColor = Colors.blue;
                    break;
                  case 2:
                    modeColor = Colors.orange;
                    break;
                  default:
                    modeColor = Colors.black26;
                }
              } else if (deforMonitorState is Defor12MonitorStateLoadingFail) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: deforMonitorState.errorPackage.message,
                        desc: deforMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (deforMonitorState
                  is Defor12MonitorStateRefetchSuccessful) {
                switch (deforMonitorState.deforMonitorData.errorCode) {
                  case 0:
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
                  AlertDialogOneBtnCustomized(
                          context: context,
                          title: warningTitle,
                          desc: warningMessage,
                          textBtn: "OK")
                      .show();
                }
                data1 = deforMonitorState.deforMonitorData.forceCylinderSp12
                    .toString();
                data3 =
                    deforMonitorState.deforMonitorData.noPressSp12.toString();
                data2 =
                    deforMonitorState.deforMonitorData.timeHoldSp12.toString();
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
                    modeColor = Colors.black26;
                    break;
                  case 1:
                    modeColor = Colors.blue;
                    break;
                  case 2:
                    modeColor = Colors.orange;
                    break;
                  default:
                    modeColor = Colors.black26;
                }
              } else if (deforMonitorState is Defor12MonitorStateRefetchFail) {
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: deforMonitorState.errorPackage.message,
                        desc: deforMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              }
            },
            builder: (context, deforMonitorState) => TabBarView(
              children: <Widget>[
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
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.0128),
                        CustomizedButton(
                          fontSize: 25,
                          width: SizeConfig.screenWidth * 0.5121,
                          height: SizeConfig.screenHeight * 0.05121,
                          onPressed: () {
                            BlocProvider.of<DeforMonitorBloc>(context)
                                .add(Defor1MonitorEventSearchingClicked());
                          },
                          text: "Truy xuất",
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                          ? Colors.green
                                          : Colors.black26,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    "CẢNH BÁO",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.0128),
                        CustomizedButton(
                          fontSize: 25,
                          width: SizeConfig.screenWidth * 0.5121,
                          height: SizeConfig.screenHeight * 0.05121,
                          onPressed: () {
                            BlocProvider.of<DeforMonitorBloc>(context)
                                .add(Defor1MonitorEventSearchingClicked());
                          },
                          text: "Truy xuất",
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                          ? Colors.green
                                          : Colors.black26,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    "CẢNH BÁO",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
