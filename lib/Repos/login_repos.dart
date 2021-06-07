import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

class LoginRepository {
  final http.Client httpClient;
  LoginRepository({this.httpClient});

  Future loginRequest(String userName, String password) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, String> body = {
      "userName": "$userName",
      "password": "$password"
    };
    try {
      final response = await this.httpClient.post(
          Uri.parse(Constants.baseUrl + "/api/auth/"),
          headers: headers,
          body: jsonEncode(body));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LoginData loginData = LoginData.fromJson(json);
        return loginData;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        return ErrorPackage.fromJson(json);
      } else if (response.statusCode == 500) {
        return ErrorPackage.fromJson(json);
      }
    } on SocketException {
      return ErrorPackage(errorCode: "", detail: "Lỗi socket", message: "");
    } catch (e) {
      ErrorPackage(errorCode: "", detail: e.toString(), message: "Lỗi lạ");
    }
  }
}
