import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Dialog/dialog.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/datetime_range.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/reli__report_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/repos/reli_report_repos.dart';

class ReliabilityReportScreen extends StatefulWidget {
  @override
  _ReliabilityReportScreenState createState() =>
      new _ReliabilityReportScreenState();
}

class _ReliabilityReportScreenState extends State<ReliabilityReportScreen> {
  String _id = 'null';
  String _timestamp = 'null';
  String _name = 'null';
  String _first = 'null';
  String _last = 'null';
  String _trytime = 'null';
  String _time = 'null';
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
                        title: "Truy xuất thất bại",
                        desc: "Vui lòng thử lại",
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              }
            },
            builder: (context, reliReportState) => TabBarView(
              children: <Widget>[
                //Độ bền
                Center(
                  child: Column(
                    children: <Widget>[
                      DateRangePickerWidget(),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<ReliReportBloc>(context)
                                .add(ReliReportEventSearchingClicked());
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
                                        DataCell(Text('${reli.name}')),
                                        DataCell(Text(reli.first)),
                                        DataCell(Text(reli.last)),
                                        DataCell(Text(reli.trytime)),
                                        DataCell(Text(reli.time)),
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
                            //Code này cho bản full
                            BlocProvider.of<ReliReportBloc>(context)
                                .add(ReliReportEventSearchingClicked());
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
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                  ],
                                ),
                              ],
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
