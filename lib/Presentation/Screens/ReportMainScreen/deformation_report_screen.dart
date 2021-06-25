import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_report_event.dart';
import 'package:mobile_app/business_logic/states/defor_report_state.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';
import 'package:mobile_app/presentation/widget/header_widget.dart';

class DeformationReportScreen extends StatefulWidget {
  @override
  _DeformationReportScreenState createState() =>
      new _DeformationReportScreenState();
}

class _DeformationReportScreenState extends State<DeformationReportScreen> {
  String _getUntilStatic = "Đến ngày";
  String _getFromStatic = "Từ ngày";
  DateTime _startStatic = DateTime.now().subtract(Duration(hours: 24 * 3));
  DateTime _endStatic = DateTime.now();
  String _getUntilBending = "Đến ngày";
  String _getFromBending = "Từ ngày";
  DateTime _startBending = DateTime.now().subtract(Duration(hours: 24 * 3));
  DateTime _endBending = DateTime.now();
  String _getUntilRock = "Đến ngày";
  String _getFromRock = "Từ ngày";
  DateTime _startRock = DateTime.now().subtract(Duration(hours: 24 * 3));
  DateTime _endRock = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => DeforReportBloc(),
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
              if (deforReportState is DeforBendingReportStateLoadingRequest) {
                loadingDialog.show();
              } else if (deforReportState
                  is DeforBendingReportStateLoadingSuccessful) {
                loadingDialog.dismiss();
              } else if (deforReportState
                  is DeforBendingReportStateLoadingFailure) {
                loadingDialog.dismiss();
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
                _getFromBending = deforReportState.getFrom;
                _getUntilBending = deforReportState.getUntil;
                _startBending = deforReportState.dateRange.start;
                _endBending = deforReportState.dateRange.end;
              } else if (deforReportState
                  is DeforStaticReportStateLoadingRequest) {
                loadingDialog.show();
              } else if (deforReportState
                  is DeforStaticReportStateLoadingSuccessful) {
                loadingDialog.dismiss();
              } else if (deforReportState
                  is DeforStaticReportStateLoadingFailure) {
                loadingDialog.dismiss();
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
                _getFromStatic = deforReportState.getFrom;
                _getUntilStatic = deforReportState.getUntil;
                _startStatic = deforReportState.dateRange.start;
                _endStatic = deforReportState.dateRange.end;
              } else if (deforReportState
                  is DeforRockReportStateLoadingRequest) {
                loadingDialog.show();
              } else if (deforReportState
                  is DeforRockReportStateLoadingSuccessful) {
                loadingDialog.dismiss();
              } else if (deforReportState
                  is DeforRockReportStateLoadingFailure) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: deforReportState.errorPackage.message,
                        desc: deforReportState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (deforReportState
                  is DeforRockReportStatePickDateRange) {
                _getFromRock = deforReportState.getFrom;
                _getUntilRock = deforReportState.getUntil;
                _startRock = deforReportState.dateRange.start;
                _endRock = deforReportState.dateRange.end;
                print(_getFromRock);
                print(_getUntilRock);
                print(_startRock);
                print(_endRock);
              }
            },
            builder: (context, deforReportState) => TabBarView(
              children: <Widget>[
                SingleChildScrollView( //length = 3 => children của tabbarview phải bằng 3
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
                                Expanded( //đừng để ý expanded
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        SizeConfig.screenWidth * 0.0509,
                                        0,
                                        0,
                                        0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Constants.mainColor),
                                      ),
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                    width: SizeConfig.screenWidth * 0.0203),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Constants.mainColor,
                                  size: 40,
                                ),
                                SizedBox(
                                    width: SizeConfig.screenWidth * 0.0203),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0,
                                        SizeConfig.screenWidth * 0.0509, 0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Constants.mainColor,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                            },),
                        SizedBox(height: SizeConfig.screenHeight * 0.0128),
                        Container(//tùy từng widget mà sẽ có child hay children
                          width: SizeConfig.screenWidth * 0.8912,
                          height: SizeConfig.screenHeight * 0.5761,
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('Tên SP'),
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
                                          DataCell(
                                              Text(deforbending.tenSanPham)),
                                          DataCell(Text(
                                              deforbending.mauSo.toString())),
                                          DataCell(Text(deforbending.taiTrong)),
                                          DataCell(Text(deforbending.thoiGian)),
                                          DataCell(
                                              Text(deforbending.doCongVenh)),
                                          DataCell(Text(deforbending.tongLoi)),
                                          DataCell(Text(deforbending.ghiChu)),
                                          DataCell(Text(
                                              deforbending.nhanVienKiemTra)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
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
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Constants.mainColor),
                                      ),
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                    width: SizeConfig.screenWidth * 0.0203),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Constants.mainColor,
                                  size: 40,
                                ),
                                SizedBox(
                                    width: SizeConfig.screenWidth * 0.0203),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0,
                                        SizeConfig.screenWidth * 0.0509, 0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Constants.mainColor,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                        SizedBox(height: SizeConfig.screenHeight * 0.0128),
                        Container(
                          width: SizeConfig.screenWidth * 0.8912,
                          height: SizeConfig.screenHeight * 0.5761,
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('Tên SP'),
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
                                          DataCell(
                                              Text(deforstatic.tenSanPham)),
                                          DataCell(Text(
                                              deforstatic.mauSo.toString())),
                                          DataCell(Text(deforstatic.tinhTrang)),
                                          DataCell(Text(deforstatic.tongLoi)),
                                          DataCell(Text(deforstatic.ghiChu)),
                                          DataCell(Text(
                                              deforstatic.nhanVienKiemTra)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
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
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Constants.mainColor),
                                      ),
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                    width: SizeConfig.screenWidth * 0.0203),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Constants.mainColor,
                                  size: 40,
                                ),
                                SizedBox(
                                    width: SizeConfig.screenWidth * 0.0203),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0,
                                        SizeConfig.screenWidth * 0.0509, 0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Constants.mainColor,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                              BlocProvider.of<DeforReportBloc>(context).add(
                                  DeforRockReportEventSearchingClicked(
                                      startTime: _startRock,
                                      stopTime: _endRock));
                            }),
                        SizedBox(height: SizeConfig.screenHeight * 0.0128),
                        Container(
                          width: SizeConfig.screenWidth * 0.8912,
                          height: SizeConfig.screenHeight * 0.5761,
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('Tên SP'),
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
                                    label: Text('Kết quả đánh giá'),
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
                                          DataCell(Text(deforrock.tenSanPham)),
                                          DataCell(
                                              Text(deforrock.mauSo.toString())),
                                          DataCell(Text(deforrock.taiTrong)),
                                          DataCell(Text(deforrock.soLanThu)),
                                          DataCell(
                                              Text(deforrock.ketQuaDanhGia)),
                                          DataCell(Text(deforrock.tongLoi)),
                                          DataCell(Text(deforrock.ghiChu)),
                                          DataCell(
                                              Text(deforrock.nhanVienKiemTra)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
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
