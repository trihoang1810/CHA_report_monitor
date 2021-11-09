import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/login.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';

class LoginRepository {
  final http.Client httpClient;
  LoginRepository({this.httpClient});

  Future loginRequest(String userName, String password) async {
    // print('userName: ${userName}');
    // print('passWord: ${password}');
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, String> body = {
      "userName": "$userName",
      "password": "$password"
    };
    try {
      final response = await this
          .httpClient
          .post(Uri.parse(Constants.baseUrl + "/api/auth/"),
              headers: headers, body: jsonEncode(body))
          .timeout(Constants.timeOutLimitation);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LoginData loginData = LoginData.fromJson(json);
        return loginData;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final errJson = jsonDecode(response.body);
        return ErrorPackage.fromJson(errJson);
      } else if (response.statusCode == 500) {
        final errJson = jsonDecode(response.body);
        return ErrorPackage(
            detail: 'Vui lòng kiểm tra lại server', message: 'Lỗi server');
      }
    } on SocketException {
      return ErrorPackage(
          errorCode: "", detail: "Không có kết nối mạng", message: "Lỗi mạng");
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
