import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class DeforRockReportRepository {
  final http.Client httpClient;
  DeforRockReportRepository({this.httpClient});
  Future loadingDeforRockDataRequest(
      DateTime startTime, DateTime stopTime) async {
    try {
      final start = (startTime == null)
          ? DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(hours: 24 * 3)))
          : DateFormat('yyyy-MM-dd').format(startTime);
      final end = (stopTime == null)
          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
          : DateFormat('yyyy-MM-dd').format(stopTime);
      print('ngay bat dau la' + start);
      print('ngay ket thuc la' + end);
      final response = await this
          .httpClient
          .get(Uri.parse(Constants.baseUrl +
              "/api/reportrocktest/?StartTime=" +
              start.toString() +
              "&StopTime=" +
              end.toString()))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        print("rock thanh cong");
        DeforRockReport deforRockReport =
            DeforRockReport.fromJson(jsonDecode(response.body));
        return deforRockReport;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        print("rock that bai 1");
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      } else {
        print("rock that bai2");
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      print("rock that bai 3");
      return ErrorPackage(
          errorCode: "", detail: "Mất kết nối mạng", message: "Lỗi mạng");
    } catch (e) {
      print("rock that bai 4");
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
