import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

String mockapi9 =
    "https://60acacda9e2d6b0017457aca.mockapi.io/api/deformation_rock_test/reli_monitor";

class ReliMonitorRepository {
  final http.Client httpClient;
  ReliMonitorRepository({this.httpClient});

  Future loadingReliDataRequest() async {
    final response = await this
        .httpClient
        .get(Uri.parse(mockapi9))
        .timeout(Constants.timeOutLimitation);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('thanh cong');
      ReliMonitorData reliMonitorData = ReliMonitorData.fromJson(json);

      return reliMonitorData;
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      print('co loi 1');
      final errJson = jsonDecode(response.body);
      return ErrorPackage.fromJson(errJson);
    } else {
      print('co loi 2');
      throw Exception("Something went wrong");
    }
  }
}
