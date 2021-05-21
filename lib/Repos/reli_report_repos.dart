import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/presentation/models/reliability_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi =
    "https://60a6123ac0c1fd00175f51db.mockapi.io/api/datatable/monitor";
List<ReliReport> reliReportList = [];

class ReliReportRepository {
  final http.Client httpClient;
  ReliReportRepository({this.httpClient});

  Future loadingReliDataRequest() async {
    final response = await this
        .httpClient
        .get(Uri.parse(mockapi))
        .timeout(Constants.timeOutLimitation);
    if (response.statusCode == 200) {
      print('thanh cong');
      reliReportList.clear();
      final reliDataJson = jsonDecode(response.body);
      for (var reliDataJson in reliDataJson) {
        ReliReport reliReportItem = ReliReport.fromJson(reliDataJson);
        reliReportList.add(reliReportItem);
      }
      print(reliReportList[2].id);
      print(reliReportList[3].first);
      return reliReportList;
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
