import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class ReliCBReportRepository {
  final http.Client httpClient;
  ReliCBReportRepository({this.httpClient});

  Future loadingReliCBDataRequest(DateTime startTime, DateTime stopTime) async {
    try {
      final start = (startTime == null)
          ? DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(hours: 24 * 3)))
          : DateFormat('yyyy-MM-dd').format(startTime);
      final end = (stopTime == null)
          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
          : DateFormat('yyyy-MM-dd').format(stopTime);
      print(start);
      print(end);
      final response = await this
          .httpClient
          .get(Uri.parse(Constants.baseUrl +
              "/api/deformationreports/?StartTime=" +
              start +
              "&StopTime=" +
              end))
          .timeout(Constants.timeOutLimitation);
      if (response.statusCode == 200) {
        print('thanh cong');
        ReliCBReport reliCBReport =
            ReliCBReport.fromJson(jsonDecode(response.body));
        return reliCBReport;
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
      return ErrorPackage(errorCode: "", detail: "Không có kết nối mạng", message: "Lỗi mạng");
    } catch (e) {
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
