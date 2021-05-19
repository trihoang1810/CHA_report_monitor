import 'good_issue_data.dart';

String employeeIdOverall = "";

class LoginData {
  Token token;
  Employee employee;
  LoginData({this.token, this.employee});
  factory LoginData.fromJson(dynamic jsonObject) {
    return LoginData(
        token: Token(
          id: jsonObject['token']['id'],
          authToken: jsonObject['token']['authToken'],
          expiredIn: jsonObject['token']['expiredIn'],
        ),
        employee: Employee(
            employeeId: jsonObject['employee']['employeeId'],
            firstName: jsonObject['employee']['firstName'],
            lastName: jsonObject['employee']['lastName']));
  }
}

class Token {
  String id;
  String authToken;
  int expiredIn;
  Token({this.id, this.authToken, this.expiredIn});
}
