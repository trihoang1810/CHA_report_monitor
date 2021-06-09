import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/widget/constant.dart';
import 'package:mobile_app/models/deformation_monitor_data.dart';

class DeforMonitorRepository {
  final http.Client httpClient;
  DeforMonitorRepository({this.httpClient});
  Future loadingDeforDataRequest() async {
    final response = await this
        .httpClient
        .get(Uri.parse(Constants.baseUrl + "/api/qualityinspectionmachine"))
        .timeout(Constants.timeOutLimitation);
    try {
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        DeforMonitorData deforMonitorData = DeforMonitorData.fromJson(json);
        return deforMonitorData;
      } else {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      return ErrorPackage(errorCode: "", detail: "Lỗi socket", message: "");
    } catch (e) {
      ErrorPackage(errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
