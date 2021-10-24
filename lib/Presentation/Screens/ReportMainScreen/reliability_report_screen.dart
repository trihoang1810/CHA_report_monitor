import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Dialog/dialog.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/reli__report_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/presentation/widget/header_widget.dart';

class ReliabilityReportScreen extends StatefulWidget {
  @override
  _ReliabilityReportScreenState createState() =>
      new _ReliabilityReportScreenState();
}

class _ReliabilityReportScreenState extends State<ReliabilityReportScreen> {
  String _getUntil = "Đến ngày";
  String _getFrom = "Từ ngày";
  DateTime _start = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _end = DateTime.now();
  String _getUntilCB = "Đến ngày";
  String _getFromCB = "Từ ngày";
  DateTime _startCB = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _endCB = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
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
              Navigator.pop(context);
            },
          ),
          title: Text("Báo cáo kiểm tra độ bền"),
        ),
        body: BlocConsumer<ReliReportBloc, ReliReportState>(
          listener: (context, reliReportState) async {
            if (reliReportState is ReliReportStateLoadingRequest) {
              loadingDialog.show();
            } else if (reliReportState is ReliReportStateLoadingSuccessful) {
              //phần hiển thị báo cáo đã có reliReportList lo
              loadingDialog.dismiss();
            } else if (reliReportState is ReliReportStateLoadingFailure) {
              loadingDialog.dismiss();
              AlertDialogOneBtnCustomized(
                      context: context,
                      title: reliReportState.errorPackage.message,
                      desc: reliReportState.errorPackage.detail,
                      textBtn: "OK",
                      closePressed: () {},
                      onPressedBtn: () {})
                  .show();
            } else if (reliReportState is ReliCBReportStateLoadingRequest) {
              loadingDialog.show();
            } else if (reliReportState is ReliCBReportStateLoadingSuccessful) {
              loadingDialog.dismiss();
            } else if (reliReportState is ReliCBReportStateLoadingFailure) {
              loadingDialog.dismiss();
              AlertDialogOneBtnCustomized(
                      context: context,
                      title: reliReportState.errorPackage.message,
                      desc: reliReportState.errorPackage.detail,
                      textBtn: "OK",
                      closePressed: () {},
                      onPressedBtn: () {})
                  .show();
            } else if (reliReportState is ReliReportStatePickDateRange) {
              _getFrom = reliReportState.getFrom;
              _getUntil = reliReportState.getUntil;
              _start = reliReportState.dateRange.start;
              _end = reliReportState.dateRange.end;
            } else if (reliReportState is ReliCBReportStatePickDateRange) {
              _getFromCB = reliReportState.getFrom;
              _getUntilCB = reliReportState.getUntil;
              _startCB = reliReportState.dateRange.start;
              _endCB = reliReportState.dateRange.end;
            } //tab
          },
          builder: (context, reliReportState) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: <Widget>[
                //Độ bền
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
                                          Text(_getFrom),
                                          Icon(Icons.calendar_today),
                                        ],
                                      ),
                                      onPressed: () =>
                                          BlocProvider.of<ReliReportBloc>(
                                                  context)
                                              .add(ReliReportEventPickDateRange(
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
                                          Text(_getUntil),
                                          Icon(Icons.calendar_today),
                                        ],
                                      ),
                                      onPressed: () =>
                                          BlocProvider.of<ReliReportBloc>(
                                                  context)
                                              .add(ReliReportEventPickDateRange(
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
                            BlocProvider.of<ReliReportBloc>(context).add(
                                ReliReportEventSearchingClicked(
                                    startTime: _start, stopTime: _end));
                          },
                        ),
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
                                headingTextStyle:
                                    TextStyle(color: Colors.white),
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xff5973c9)),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('Tên SP'),
                                  ),
                                  DataColumn(
                                    label: Text('Ngày bắt đầu'),
                                  ),
                                  DataColumn(
                                    label: Text('Ngày kết thúc'),
                                  ),
                                  DataColumn(
                                    label: Text('Số lần thử'),
                                  ),
                                  DataColumn(
                                    label: Text('T/gian lên'),
                                  ),
                                ],
                                rows: reliReportList
                                    .map(
                                      (reli) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(reli.tenSanPham)),
                                          DataCell(
                                              Text(reli.ngayBatDau.toString())),
                                          DataCell(Text(
                                              reli.ngayKetThuc.toString())),
                                          DataCell(
                                              Text(reli.soLanThu.toString())),
                                          DataCell(
                                              Text(reli.thoiGianDongEmNap)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ), //thuộc về độ bền êm
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Độ bền CB
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
                                          Text(_getFromCB),
                                          Icon(Icons.calendar_today),
                                        ],
                                      ),
                                      onPressed: () => BlocProvider.of<
                                              ReliReportBloc>(context)
                                          .add(ReliCBReportEventPickDateRange(
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
                                          Text(_getUntilCB),
                                          Icon(Icons.calendar_today),
                                        ],
                                      ),
                                      onPressed: () => BlocProvider.of<
                                              ReliReportBloc>(context)
                                          .add(ReliCBReportEventPickDateRange(
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
                            onPressed: () async {
                              print('clicking report cb searching');
                              //Code này cho bản full
                              BlocProvider.of<ReliReportBloc>(context).add(
                                  ReliCBReportEventSearchingClicked(
                                      startTime: _startCB, stopTime: _endCB));
                            }), //thuộc về tab độ bền CB
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
                                headingTextStyle:
                                    TextStyle(color: Colors.white),
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xff5973c9)),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('Tên SP'),
                                  ),
                                  DataColumn(
                                    label: Text('Ngày bắt đầu'),
                                  ),
                                  DataColumn(
                                    label: Text('Ngày kết thúc'),
                                  ),
                                  DataColumn(
                                    label: Text('Số lần thử'),
                                  ),
                                  DataColumn(
                                    label: Text('T/gian lên'),
                                  ),
                                ],
                                rows: reliCBReportList
                                    .map(
                                      (reliCB) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(reliCB.tenSanPham)),
                                          DataCell(Text(reliCB.ngayBatDau)),
                                          DataCell(Text(reliCB.ngayKetThuc)),
                                          DataCell(
                                              Text(reliCB.soLanThu.toString())),
                                          DataCell(
                                              Text(reliCB.thoiGianDongEmNap)),
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
        ),
      ),
    );
  }
}
