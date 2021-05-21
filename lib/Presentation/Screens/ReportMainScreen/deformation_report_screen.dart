import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:mobile_app/Presentation/Widget/datetime_range.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';

class DeformationReportScreen extends StatefulWidget {
  @override
  _DeformationReportScreenState createState() =>
      new _DeformationReportScreenState();
}

class _DeformationReportScreenState extends State<DeformationReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Chịu va đập"),
              Tab(text: "Chịu lực uốn"),
              Tab(text: "Rock Start"),
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
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  DateRangePickerWidget(),
                  CustomizedButton(text: "Truy xuất", onPressed: () {}),
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
                              label: Text('Mẫu'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 1'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 2'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 3'),
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
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
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
                  CustomizedButton(text: "Truy xuất", onPressed: () {}),
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
                              label: Text('Mẫu'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 1'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 2'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 3'),
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
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
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
            Center(
              child: Column(
                children: <Widget>[
                  DateRangePickerWidget(),
                  CustomizedButton(text: "Truy xuất", onPressed: () {}),
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
                              label: Text('Mẫu'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 1'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 2'),
                            ),
                            DataColumn(
                              label: Text('Vị trí 3'),
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
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
                                DataCell(Text('Data')),
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
    );
  }
}
