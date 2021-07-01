import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class ReliMonitorRepository {
  final http.Client httpClient;
  ReliMonitorRepository({this.httpClient});

  Future loadingReliDataRequest() async {
    final response = await this //await là đợi cho tới khi thực hiện xong mới nhảy qua lệnh kế tiếp
        .httpClient
        .get(Uri.parse(Constants.baseUrl + "/api/monitorreliability"))
        .timeout(Constants.timeOutLimitation);
    try {
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ReliMonitorData reliMonitorData = ReliMonitorData.fromJson(json);
        //print(reliMonitorData.alarm);
        return reliMonitorData; 
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final errJson = jsonDecode(response.body); //4xx là bad request
        return ErrorPackage.fromJson(errJson);
      } else {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      }
    } on SocketException {
      return ErrorPackage(
          errorCode: "", detail: "Mất kết nối mạng", message: "Lỗi mạng");
    } catch (e) { //messagbe box
      return ErrorPackage(
          errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
