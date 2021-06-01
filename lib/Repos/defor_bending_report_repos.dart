import 'dart:convert';
import 'dart:io';

import 'package:mobile_app/models/deformation_bending_data.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi2 =
    "https://60a6123ac0c1fd00175f51db.mockapi.io/api/datatable/deformation_lu_report";

List<DeforBendingReport> deforBendingReportList = [];

class DeforBendingReportRepository {
  final http.Client httpClient;
  DeforBendingReportRepository({this.httpClient});
  Future loadingDeforBendingDataRequest() async {
    try {
      final response = await this
          .httpClient
          .get(Uri.parse(mockapi2))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        print('tai ve data deforbending thanh cong');
        deforBendingReportList.clear();
        final deforBendingDataJson = jsonDecode(response.body);
        for (var deforBendingDataJson in deforBendingDataJson) {
          DeforBendingReport deforBendingReportItem =
              DeforBendingReport.fromJson(deforBendingDataJson);
          deforBendingReportList.add(deforBendingReportItem);
        }
        return deforBendingReportList;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      } else {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      return ErrorPackage(errorCode: "", detail: "Lỗi socket", message: "");
    } catch (e) {
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
