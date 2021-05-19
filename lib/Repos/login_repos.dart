import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/Presentation/Models/login.dart';

const baseUrl = "https://testweb20201214001633.azurewebsites.net";

class LoginRepository {
  final http.Client httpClient;
  LoginRepository({this.httpClient});
  Future loginRequest(String userName, String password) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, String> body = {
      "userName": "$userName",
      "password": "$password"
    };
    final response = await this.httpClient.post(
        Uri.parse(baseUrl + "/api/auth/"),
        headers: headers,
        body: jsonEncode(body));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      LoginData loginData = LoginData.fromJson(json);
      return loginData;
    } else if (response.statusCode == 400) {
      return ErrorPackage.fromJson(json);
    }
  }
}
