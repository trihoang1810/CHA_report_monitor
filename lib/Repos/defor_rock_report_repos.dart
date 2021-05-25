import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi4 =
    "https://60acacda9e2d6b0017457aca.mockapi.io/api/deformation_rock_test/rocktest";

List<DeforRockReport> deforRockReportList = [];

class DeforRockReportRepository {
  final http.Client httpClient;
  DeforRockReportRepository({this.httpClient});
  Future loadingDeforRockDataRequest() async {
    final response = await this
        .httpClient
        .get(Uri.parse(mockapi4))
        .timeout(Constants.timeOutLimitation);
    if (response.statusCode == 200) {
      print('tai ve data deforbending thanh cong');
      deforRockReportList.clear();
      final deforRockDataJson = jsonDecode(response.body);
      for (var deforRockDataJson in deforRockDataJson) {
        DeforRockReport deforRockReportItem =
            DeforRockReport.fromJson(deforRockDataJson);
        deforRockReportList.add(deforRockReportItem);
      }
      return deforRockReportList;
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      final errJson = jsonDecode(response.body);
      return ErrorPackage.fromJson(errJson);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
