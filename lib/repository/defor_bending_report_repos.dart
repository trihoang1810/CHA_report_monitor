import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mobile_app/model/deformation_bending_data.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';

class DeforBendingReportRepository {
  final http.Client httpClient;
  DeforBendingReportRepository({this.httpClient});
  Future loadingDeforBendingDataRequest(
      DateTime startTime, DateTime stopTime) async {
    try {
      final start = (startTime == null)
          ? DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(hours: 24 * 3)))
          : DateFormat('yyyy-MM-dd').format(startTime);
      final end = (stopTime == null)
          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
          : DateFormat('yyyy-MM-dd').format(stopTime);
      final response = await this
          .httpClient
          .get(Uri.parse(Constants.baseUrl +
              "/api/curlingforcereports/?StartTime=" +
              start.toString() +
              "&StopTime=" +
              end.toString()))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        DeforBendingReport deforBendingReport =
            DeforBendingReport.fromJson(jsonDecode(response.body));
        return deforBendingReport;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      } else {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      return ErrorPackage(
          errorCode: "", detail: "Mất kết nối mạng", message: "Lỗi mạng");
    } on TimeoutException {
      return ErrorPackage(
          errorCode: "",
          detail: "Kết nối mạng không ổn định",
          message: "Lỗi mạng");
    } catch (e) {
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi hệ thống");
    }
  }
}
