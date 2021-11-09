import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_report_event.dart';
import 'package:mobile_app/business_logic/states/defor_report_state.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';
import 'package:mobile_app/presentation/widget/error_state_widget.dart';
import 'package:mobile_app/presentation/widget/header_widget.dart';

class DeformationReportScreen extends StatefulWidget {
  @override
  _DeformationReportScreenState createState() =>
      new _DeformationReportScreenState();
}

class _DeformationReportScreenState extends State<DeformationReportScreen> {
  Completer<void> _completerDeforBending;
  Completer<void> _completerDeforStatic;
  Completer<void> _completerDeforRock;

  String _getUntilStatic = "Đến ngày";
  String _getFromStatic = "Từ ngày";
  DateTime _startStatic = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _endStatic = DateTime.now();
  String _getUntilBending = "Đến ngày";
  String _getFromBending = "Từ ngày";
  DateTime _startBending = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _endBending = DateTime.now();
  String _getUntilRock = "Đến ngày";
  String _getFromRock = "Từ ngày";
  DateTime _startRock = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _endRock = DateTime.now();
  @override
  void initState() {
    super.initState();
    _completerDeforBending = Completer<void>();
    _completerDeforRock = Completer<void>();
    _completerDeforStatic = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Chịu lực uốn"),
              Tab(text: "Chịu tải tĩnh"),
              Tab(text: "Rock Test"),
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
        body: BlocConsumer<DeforReportBloc, DeforReportState>(
          listener: (context, deforReportState) async {
            if (deforReportState is DeforBendingReportStateLoadingSuccessful) {
              _completerDeforBending?.complete();
              _completerDeforBending = Completer();
            } else if (deforReportState
                is DeforBendingReportStateLoadingFailure) {
              _completerDeforBending?.complete();
              _completerDeforBending = Completer();
              AlertDialogOneBtnCustomized(
                      context: context,
                      title: deforReportState.errorPackage.message,
                      desc: deforReportState.errorPackage.detail,
                      textBtn: "OK",
                      closePressed: () {},
                      onPressedBtn: () {})
                  .show();
            } else if (deforReportState
                is DeforBendingReportStatePickDateRange) {
              _getFromBending = deforReportState.getFrom ??
                  DateFormat('yyyy/MM/dd')
                      .format(DateTime.now().subtract(Duration(hours: 24 * 2)));
              _getUntilBending = deforReportState.getUntil ??
                  DateFormat('yyyy/MM/dd').format(DateTime.now());
              _startBending = deforReportState.dateRange.start ??
                  DateTime.now().subtract(Duration(hours: 24 * 2));
              _endBending = deforReportState.dateRange.end ?? DateTime.now();
            } else if (deforReportState
                is DeforStaticReportStateLoadingSuccessful) {
              _completerDeforStatic?.complete();
              _completerDeforStatic = Completer();
            } else if (deforReportState
                is DeforStaticReportStateLoadingFailure) {
              _completerDeforStatic?.complete();
              _completerDeforStatic = Completer();
              AlertDialogOneBtnCustomized(
                      context: context,
                      title: deforReportState.errorPackage.message,
                      desc: deforReportState.errorPackage.detail,
                      textBtn: "OK",
                      closePressed: () {},
                      onPressedBtn: () {})
                  .show();
            } else if (deforReportState
                is DeforStaticReportStatePickDateRange) {
              _getFromStatic = deforReportState.getFrom ??
                  DateFormat('yyyy/MM/dd')
                      .format(DateTime.now().subtract(Duration(hours: 24 * 2)));
              _getUntilStatic = deforReportState.getUntil ??
                  DateFormat('yyyy/MM/dd').format(DateTime.now());
              _startStatic = deforReportState.dateRange.start ??
                  DateTime.now().subtract(Duration(hours: 24 * 2));
              _endStatic = deforReportState.dateRange.end ?? DateTime.now();
            } else if (deforReportState
                is DeforRockReportStateLoadingSuccessful) {
              _completerDeforRock?.complete();
              _completerDeforRock = Completer();
            } else if (deforReportState is DeforRockReportStateLoadingFailure) {
              _completerDeforRock?.complete();
              _completerDeforRock = Completer();
              AlertDialogOneBtnCustomized(
                      context: context,
                      title: deforReportState.errorPackage.message,
                      desc: deforReportState.errorPackage.detail,
                      textBtn: "OK",
                      closePressed: () {},
                      onPressedBtn: () {})
                  .show();
            } else if (deforReportState is DeforRockReportStatePickDateRange) {
              _getFromRock = deforReportState.getFrom ??
                  DateFormat('yyyy/MM/dd')
                      .format(DateTime.now().subtract(Duration(hours: 24 * 2)));
              _getUntilRock = deforReportState.getUntil ??
                  DateFormat('yyyy/MM/dd').format(DateTime.now());
              _startRock = deforReportState.dateRange.start ??
                  DateTime.now().subtract(Duration(hours: 24 * 2));
              _endRock = deforReportState.dateRange.end ?? DateTime.now();
            }
          },
          builder: (context, deforReportState) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<DeforReportBloc>(context).add(
                        DeforBendingReportEventSearchingClicked(
                            startTime: _startBending, stopTime: _endBending));
                    return _completerDeforBending.future;
                  },
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        //length = 3 => children của tabbarview phải bằng 3
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, SizeConfig.screenHeight * 0.0256, 0, 0),
                                child: HeaderWidget(
                                  title: 'Chọn khoảng thời gian',
                                  child: Row(
                                    children: [
                                      Expanded(
                                        //đừng để ý expanded
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.screenWidth * 0.0509,
                                              0,
                                              0,
                                              0),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color: Constants.mainColor),
                                            ),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getFromBending),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforBendingReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Constants.mainColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              SizeConfig.screenWidth * 0.0509,
                                              0),
                                          child: RaisedButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Constants.mainColor,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getUntilBending),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforBendingReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomizedButton(
                                //height/width ko khai báo sẽ để mặc định,
                                text: "Truy xuất",
                                onPressed: () {
                                  BlocProvider.of<DeforReportBloc>(context).add(
                                      DeforBendingReportEventSearchingClicked(
                                          startTime: _startBending,
                                          stopTime: _endBending));
                                },
                              ),
                              SizedBox(
                                  height: SizeConfig.screenHeight * 0.0128),
                              BlocBuilder<DeforReportBloc, DeforReportState>(
                                builder: (context, state) {
                                  if (state
                                      is DeforBendingReportStateLoadingRequest) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is DeforBendingReportStateLoadingSuccessful) {
                                    return deforBendingReportList.length > 0
                                        ? Container(
                                            //tùy từng widget mà sẽ có child hay children
                                            width:
                                                SizeConfig.screenWidth * 0.8912,
                                            height: SizeConfig.screenHeight *
                                                0.5761,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: DataTable(
                                                  headingTextStyle: TextStyle(
                                                      color: Colors.white),
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Color(
                                                                  0xff5973c9)),
                                                  // headingRowColor: Color(0xff5973c9),
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text('Tên SP'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày bắt đầu'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày kết thúc'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Mẫu số'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tải trọng'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Thời gian'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Độ cong vênh'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tổng lỗi'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Ghi chú'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('NV kiểm tra'),
                                                    ),
                                                  ],
                                                  rows: deforBendingReportList
                                                      .map(
                                                        (deforbending) =>
                                                            DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                deforbending
                                                                    .tenSanPham)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ngayBatDau)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ngayKetThuc)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .mauSo
                                                                    .toString())),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .taiTrong)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .thoiGian)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .doCongVenh)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .tongLoi)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ghiChu)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .nhanVienKiemTra)),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 100),
                                                  Center(
                                                    child: ExceptionErrorState(
                                                      title: 'Thông báo',
                                                      message:
                                                          'Không tìm thấy báo cáo trong ngày, vui lòng thử lại',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                  } else if (state
                                      is DeforBendingReportStateLoadingFailure) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Center(
                                          child: ExceptionErrorState(
                                            title: state.errorPackage.message,
                                            message: state.errorPackage.detail,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return deforBendingReportList.length > 0
                                      ? Container(
                                          //tùy từng widget mà sẽ có child hay children
                                          width:
                                              SizeConfig.screenWidth * 0.8912,
                                          height:
                                              SizeConfig.screenHeight * 0.5761,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingTextStyle: TextStyle(
                                                    color: Colors.white),
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Color(0xff5973c9)),
                                                // headingRowColor: Color(0xff5973c9),
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Text('Tên SP'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ngày bắt đầu'),
                                                  ),
                                                  DataColumn(
                                                    label:
                                                        Text('Ngày kết thúc'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Mẫu số'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tải trọng'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Thời gian'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Độ cong vênh'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tổng lỗi'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ghi chú'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('NV kiểm tra'),
                                                  ),
                                                ],
                                                rows: deforBendingReportList
                                                    .map(
                                                      (deforbending) => DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(Text(
                                                              deforbending
                                                                  .tenSanPham)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ngayBatDau)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ngayKetThuc)),
                                                          DataCell(Text(
                                                              deforbending.mauSo
                                                                  .toString())),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .taiTrong)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .thoiGian)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .doCongVenh)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .tongLoi)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ghiChu)),
                                                          DataCell(Text(deforbending
                                                              .nhanVienKiemTra)),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 100),
                                                Center(
                                                  child: ExceptionErrorState(
                                                    imageDirectory:
                                                        'lib/assets/touch.png',
                                                    title: 'Thông báo',
                                                    message:
                                                        'Nhấn nút truy xuất để xem báo cáo',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<DeforReportBloc>(context).add(
                        DeforStaticReportEventSearchingClicked(
                            startTime: _startStatic, stopTime: _endStatic));
                    return _completerDeforStatic.future;
                  },
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, SizeConfig.screenHeight * 0.0256, 0, 0),
                                child: HeaderWidget(
                                  title: 'Chọn khoảng thời gian',
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.screenWidth * 0.0509,
                                              0,
                                              0,
                                              0),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color: Constants.mainColor),
                                            ),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getFromStatic),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforStaticReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Constants.mainColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              SizeConfig.screenWidth * 0.0509,
                                              0),
                                          child: RaisedButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Constants.mainColor,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getUntilStatic),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforStaticReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomizedButton(
                                  text: "Truy xuất",
                                  onPressed: () {
                                    BlocProvider.of<DeforReportBloc>(context).add(
                                        DeforStaticReportEventSearchingClicked(
                                            startTime: _startStatic,
                                            stopTime: _endStatic));
                                  }),
                              SizedBox(
                                  height: SizeConfig.screenHeight * 0.0128),
                              BlocBuilder<DeforReportBloc, DeforReportState>(
                                builder: (context, state) {
                                  if (state
                                      is DeforStaticReportStateLoadingRequest) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is DeforStaticReportStateLoadingSuccessful) {
                                    return deforStaticReportList.length > 0
                                        ? Container(
                                            width:
                                                SizeConfig.screenWidth * 0.8912,
                                            height: SizeConfig.screenHeight *
                                                0.5761,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: DataTable(
                                                  headingTextStyle: TextStyle(
                                                      color: Colors.white),
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Color(
                                                                  0xff5973c9)),
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text('Tên SP'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày bắt đầu'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày kết thúc'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Mẫu số'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tình trạng'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tổng lỗi'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Ghi chú'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('NV kiểm tra'),
                                                    ),
                                                  ],
                                                  rows: deforStaticReportList
                                                      .map(
                                                        (deforstatic) =>
                                                            DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .tenSanPham)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .ngayBatDau)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .ngayKetThuc)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .mauSo
                                                                    .toString())),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .tinhTrang)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .tongLoi)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .ghiChu)),
                                                            DataCell(Text(
                                                                deforstatic
                                                                    .nhanVienKiemTra)),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 100),
                                                  Center(
                                                    child: ExceptionErrorState(
                                                      title: 'Thông báo',
                                                      message:
                                                          'Không tìm thấy báo cáo trong ngày, vui lòng thử lại',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                  } else if (state
                                      is DeforStaticReportStateLoadingFailure) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Center(
                                          child: ExceptionErrorState(
                                            title: state.errorPackage.message,
                                            message: state.errorPackage.detail,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return deforStaticReportList.length > 0
                                      ? Container(
                                          width:
                                              SizeConfig.screenWidth * 0.8912,
                                          height:
                                              SizeConfig.screenHeight * 0.5761,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingTextStyle: TextStyle(
                                                    color: Colors.white),
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Color(0xff5973c9)),
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Text('Tên SP'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ngày bắt đầu'),
                                                  ),
                                                  DataColumn(
                                                    label:
                                                        Text('Ngày kết thúc'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Mẫu số'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tình trạng'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tổng lỗi'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ghi chú'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('NV kiểm tra'),
                                                  ),
                                                ],
                                                rows: deforStaticReportList
                                                    .map(
                                                      (deforstatic) => DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .tenSanPham)),
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .ngayBatDau)),
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .ngayKetThuc)),
                                                          DataCell(Text(
                                                              deforstatic.mauSo
                                                                  .toString())),
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .tinhTrang)),
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .tongLoi)),
                                                          DataCell(Text(
                                                              deforstatic
                                                                  .ghiChu)),
                                                          DataCell(Text(deforstatic
                                                              .nhanVienKiemTra)),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 100),
                                                Center(
                                                  child: ExceptionErrorState(
                                                    imageDirectory:
                                                        'lib/assets/touch.png',
                                                    title: 'Thông báo',
                                                    message:
                                                        'Nhấn nút truy xuất để xem báo cáo',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<DeforReportBloc>(context).add(
                        DeforRockReportEventSearchingClicked(
                            startTime: _startRock, stopTime: _endRock));
                    return _completerDeforRock.future;
                  },
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, SizeConfig.screenHeight * 0.0256, 0, 0),
                                child: HeaderWidget(
                                  title: 'Chọn khoảng thời gian',
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.screenWidth * 0.0509,
                                              0,
                                              0,
                                              0),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color: Constants.mainColor),
                                            ),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getFromRock),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforRockReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Constants.mainColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              SizeConfig.screenWidth * 0.0509,
                                              0),
                                          child: RaisedButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Constants.mainColor,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getUntilRock),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforRockReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomizedButton(
                                  text: "Truy xuất",
                                  onPressed: () {
                                    BlocProvider.of<DeforReportBloc>(context)
                                        .add(
                                            DeforRockReportEventSearchingClicked(
                                                startTime: _startRock,
                                                stopTime: _endRock));
                                  }),
                              SizedBox(
                                  height: SizeConfig.screenHeight * 0.0128),
                              BlocBuilder<DeforReportBloc, DeforReportState>(
                                builder: (context, state) {
                                  if (state
                                      is DeforRockReportStateLoadingRequest) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is DeforRockReportStateLoadingSuccessful) {
                                    return deforRockReportList.length > 0
                                        ? Container(
                                            width:
                                                SizeConfig.screenWidth * 0.8912,
                                            height: SizeConfig.screenHeight *
                                                0.5761,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: DataTable(
                                                  headingTextStyle: TextStyle(
                                                      color: Colors.white),
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Color(
                                                                  0xff5973c9)),
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text('Tên SP'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày bắt đầu'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày kết thúc'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Mẫu số'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tải trọng'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Số lần thử'),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                          'Kết quả đánh giá'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tổng lỗi'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Ghi chú'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('NV kiểm tra'),
                                                    ),
                                                  ],
                                                  rows: deforRockReportList
                                                      .map(
                                                        (deforrock) => DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                deforrock
                                                                    .tenSanPham)),
                                                            DataCell(Text(
                                                                deforrock
                                                                    .ngayBatDau)),
                                                            DataCell(Text(deforrock
                                                                .ngayKetThuc)),
                                                            DataCell(Text(
                                                                deforrock.mauSo
                                                                    .toString())),
                                                            DataCell(Text(
                                                                deforrock
                                                                    .taiTrong)),
                                                            DataCell(Text(
                                                                deforrock
                                                                    .soLanThu)),
                                                            DataCell(Text(deforrock
                                                                .ketQuaDanhGia)),
                                                            DataCell(Text(
                                                                deforrock
                                                                    .tongLoi)),
                                                            DataCell(Text(
                                                                deforrock
                                                                    .ghiChu)),
                                                            DataCell(Text(deforrock
                                                                .nhanVienKiemTra)),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 100),
                                                  Center(
                                                    child: ExceptionErrorState(
                                                      title: 'Thông báo',
                                                      message:
                                                          'Không tìm thấy báo cáo trong ngày, vui lòng thử lại',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                  } else if (state
                                      is DeforRockReportStateLoadingFailure) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Center(
                                          child: ExceptionErrorState(
                                            title: state.errorPackage.message,
                                            message: state.errorPackage.detail,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return deforRockReportList.length > 0
                                      ? Container(
                                          width:
                                              SizeConfig.screenWidth * 0.8912,
                                          height:
                                              SizeConfig.screenHeight * 0.5761,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingTextStyle: TextStyle(
                                                    color: Colors.white),
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Color(0xff5973c9)),
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Text('Tên SP'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ngày bắt đầu'),
                                                  ),
                                                  DataColumn(
                                                    label:
                                                        Text('Ngày kết thúc'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Mẫu số'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tải trọng'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Số lần thử'),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                        'Kết quả đánh giá'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tổng lỗi'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ghi chú'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('NV kiểm tra'),
                                                  ),
                                                ],
                                                rows: deforRockReportList
                                                    .map(
                                                      (deforrock) => DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(Text(
                                                              deforrock
                                                                  .tenSanPham)),
                                                          DataCell(Text(
                                                              deforrock
                                                                  .ngayBatDau)),
                                                          DataCell(Text(deforrock
                                                              .ngayKetThuc)),
                                                          DataCell(Text(
                                                              deforrock.mauSo
                                                                  .toString())),
                                                          DataCell(Text(
                                                              deforrock
                                                                  .taiTrong)),
                                                          DataCell(Text(
                                                              deforrock
                                                                  .soLanThu)),
                                                          DataCell(Text(deforrock
                                                              .ketQuaDanhGia)),
                                                          DataCell(Text(
                                                              deforrock
                                                                  .tongLoi)),
                                                          DataCell(Text(
                                                              deforrock
                                                                  .ghiChu)),
                                                          DataCell(Text(deforrock
                                                              .nhanVienKiemTra)),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 100),
                                                Center(
                                                  child: ExceptionErrorState(
                                                    imageDirectory:
                                                        'lib/assets/touch.png',
                                                    title: 'Thông báo',
                                                    message:
                                                        'Nhấn nút truy xuất để xem báo cáo',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
