import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/datetime_range.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_report_event.dart';
import 'package:mobile_app/business_logic/states/defor_report_state.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';
import 'package:mobile_app/repos/defor_bending_report_repos.dart';
import 'package:mobile_app/repos/defor_rock_report_repos.dart';
import 'package:mobile_app/repos/defor_static_report_repos.dart';

class DeformationReportScreen extends StatefulWidget {
  @override
  _DeformationReportScreenState createState() =>
      new _DeformationReportScreenState();
}

class _DeformationReportScreenState extends State<DeformationReportScreen> {
  @override
  Widget build(BuildContext context) {
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
              }
            },
            builder: (context, deforReportState) => TabBarView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      DateRangePickerWidget(),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<DeforReportBloc>(context)
                                .add(DeforBendingReportEventSearchingClicked());
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
                                        DataCell(Text(deforbending.nume)),
                                        DataCell(
                                            Text(deforbending.id.toString())),
                                        DataCell(Text(deforbending.taitrong)),
                                        DataCell(Text(deforbending.time)),
                                        DataCell(Text(deforbending.dcv)),
                                        DataCell(Text(deforbending.tongloi)),
                                        DataCell(Text(deforbending.nxet)),
                                        DataCell(Text(deforbending.nvkt)),
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
                //Độ bền CB
                Center(
                  child: Column(
                    children: <Widget>[
                      DateRangePickerWidget(),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<DeforReportBloc>(context)
                                .add(DeforStaticReportEventSearchingClicked());
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
                                        DataCell(Text(deforstatic.name)),
                                        DataCell(
                                            Text(deforstatic.id.toString())),
                                        DataCell(Text(deforstatic.status)),
                                        DataCell(Text(deforstatic.total)),
                                        DataCell(Text(deforstatic.comment)),
                                        DataCell(Text(deforstatic.employee)),
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
                Center(
                  child: Column(
                    children: <Widget>[
                      DateRangePickerWidget(),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<DeforReportBloc>(context)
                                .add(DeforRockReportEventSearchingClicked());
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
                                        DataCell(Text(deforrock.name)),
                                        DataCell(Text(deforrock.id.toString())),
                                        DataCell(Text(deforrock.weight)),
                                        DataCell(Text(deforrock.trytime)),
                                        DataCell(Text(deforrock.result)),
                                        DataCell(Text(deforrock.total)),
                                        DataCell(Text(deforrock.comment)),
                                        DataCell(Text(deforrock.employee)),
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
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
