import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class ReliReportRepository {
  final http.Client httpClient;
  ReliReportRepository({this.httpClient});

  Future loadingReliDataRequest(DateTime startTime, DateTime stopTime) async {
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
              "/api/reportreliability/?StartTime=" +
              start.toString() +
              "&StopTime=" +
              end.toString()))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        ReliReport reliReport = ReliReport.fromJson(jsonDecode(response.body));
        return reliReport;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        print('co loi 1');
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      } else {
        print('co loi 2');
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      print('loi socket');
      return ErrorPackage(errorCode: "", detail: "Không có kết nối mạng", message: "Lỗi mạng");
    } catch (e) {
      print('loi catch' + e.toString());
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
