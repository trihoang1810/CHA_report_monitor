import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi =
    "https://60a6123ac0c1fd00175f51db.mockapi.io/api/datatable/reli_cb_report";
List<ReliCBReport> reliCBReportList = [];

class ReliCBReportRepository {
  final http.Client httpClient;
  ReliCBReportRepository({this.httpClient});

  Future loadingReliCBDataRequest() async {
    final response = await this
        .httpClient
        .get(Uri.parse(mockapi))
        .timeout(Constants.timeOutLimitation);
    if (response.statusCode == 200) {
      print('thanh cong');
      reliCBReportList.clear();
      final reliCBDataJson = jsonDecode(response.body);
      for (var reliCBDataJson in reliCBDataJson) {
        ReliCBReport reliCBReportItem = ReliCBReport.fromJson(reliCBDataJson);
        reliCBReportList.add(reliCBReportItem);
      }
      print(reliCBReportList[2].id);
      print(reliCBReportList[3].first);
      return reliCBReportList;
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      print('co loi 1');
      final errJson = jsonDecode(response.body);
      return ErrorPackage.fromJson(errJson);
    } else {
      print('co loi 2');
      throw Exception("Something went wrong");
    }
  }
}
