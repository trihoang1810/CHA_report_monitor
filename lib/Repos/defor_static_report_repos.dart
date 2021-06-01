import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/deformation_staticload_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi3 =
    "https://60a6123ac0c1fd00175f51db.mockapi.io/api/datatable/static_load";

List<DeforStaticReport> deforStaticReportList = [];

class DeforStaticReportRepository {
  final http.Client httpClient;
  DeforStaticReportRepository({this.httpClient});
  Future loadingDeforStaticDataRequest() async {
    try {
      final response = await this
          .httpClient
          .get(Uri.parse(mockapi3))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        print('tai ve data deforstatic thanh cong');
        deforStaticReportList.clear();
        final deforStaticDataJson = jsonDecode(response.body);
        for (var deforStaticDataJson in deforStaticDataJson) {
          DeforStaticReport deforStaticReportItem =
              DeforStaticReport.fromJson(deforStaticDataJson);
          deforStaticReportList.add(deforStaticReportItem);
        }
        return deforStaticReportList;
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
