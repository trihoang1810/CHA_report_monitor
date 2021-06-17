import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class ReliCBMonitorRepository {
  final http.Client httpClient;
  ReliCBMonitorRepository({this.httpClient});

  Future loadingReliCBDataRequest() async {
    try {
      final response = await this
          .httpClient
          .get(Uri.parse(Constants.baseUrl + "/api/monitordeformation"))
          .timeout(Constants.timeOutLimitation);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('thanh cong 5');
        ReliCBMonitorData reliCBMonitorData = ReliCBMonitorData.fromJson(json);
        return reliCBMonitorData;
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
      return ErrorPackage(
          errorCode: "", detail: "Mất kết nối mạng", message: "Lỗi mạng");
    } catch (e) {
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
