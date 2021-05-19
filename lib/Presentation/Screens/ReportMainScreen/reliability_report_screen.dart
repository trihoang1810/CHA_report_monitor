import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/datetime_range.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class ReliabilityReportScreen extends StatefulWidget {
  @override
  _ReliabilityReportScreenState createState() =>
      new _ReliabilityReportScreenState();
}

class _ReliabilityReportScreenState extends State<ReliabilityReportScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
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
          body: TabBarView(
            children: <Widget>[
              //Độ bền
              Center(
                child: Column(
                  children: <Widget>[
                    DateRangePickerWidget(),
                    SizedBox(height: 30),
                    CustomizedButton(text: "Truy xuất", onPressed: () {}),
                    SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 500,
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
              //Độ bền CB
              Center(
                child: Column(
                  children: <Widget>[
                    DateRangePickerWidget(),
                    SizedBox(height: 30),
                    CustomizedButton(text: "Truy xuất", onPressed: () {}),
                    SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 500,
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
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
