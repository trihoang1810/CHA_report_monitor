import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/Presentation/Dialog/dialog.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/reli__report_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/presentation/widget/datetime_range.dart';
import 'package:mobile_app/presentation/widget/header_widget.dart';
import 'package:mobile_app/repos/reli_cb_report_repos.dart';

class ReliabilityReportScreen extends StatefulWidget {
  @override
  _ReliabilityReportScreenState createState() =>
      new _ReliabilityReportScreenState();
}

class _ReliabilityReportScreenState extends State<ReliabilityReportScreen> {
  String _getUntil = "Đến ngày";
  String _getFrom = "Từ ngày";
  DateTime _start = DateTime.now().subtract(Duration(hours: 24 * 3));
  DateTime _end = DateTime.now();
  @override
  Widget build(BuildContext context) {
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => ReliReportBloc(),
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
            title: Text("Báo cáo kiểm tra độ bền"),
          ),
          body: BlocConsumer<ReliReportBloc, ReliReportState>(
            listener: (context, reliReportState) async {
              if (reliReportState is ReliReportStateLoadingRequest) {
                loadingDialog.show();
              } else if (reliReportState is ReliReportStateLoadingSuccessful) {
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
              } else if (reliReportState
                  is ReliCBReportStateLoadingSuccessful) {
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
              }
            },
            builder: (context, reliReportState) => TabBarView(
              children: <Widget>[
                //Độ bền
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: HeaderWidget(
                          title: 'Chọn khoảng thời gian',
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                        BlocProvider.of<ReliReportBloc>(context)
                                            .add(ReliReportEventPickDateRange(
                                                context: context)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Constants.mainColor,
                                size: 40,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                                        BlocProvider.of<ReliReportBloc>(context)
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
                          }),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 390,
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
                                        DataCell(
                                            Text(reli.ngayKetThuc.toString())),
                                        DataCell(
                                            Text(reli.soLanThu.toString())),
                                        DataCell(Text(reli.thoiGianDongEmNap)),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Độ bền CB
                Center(
                  child: Column(
                    children: <Widget>[
                      DateRangePickerWidget(),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () async {
                            print('clicking report cb searching');
                            //Code này cho bản full
                            BlocProvider.of<ReliReportBloc>(context)
                                .add(ReliCBReportEventSearchingClicked());
                          }),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 390,
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
                                        DataCell(Text('${reliCB.name}')),
                                        DataCell(Text(reliCB.first)),
                                        DataCell(Text(reliCB.last)),
                                        DataCell(Text(reliCB.trytime)),
                                        DataCell(Text(reliCB.time)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
