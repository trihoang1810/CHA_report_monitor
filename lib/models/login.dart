String employeeIdOverall = "";
String employeeLastNameOverall = "";
String employeeFirstNameOverall = "";
String tokenOverall = "";

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

class Employee {
  String employeeId;
  String firstName;
  String lastName;
  String name;
  Employee({this.employeeId, this.firstName, this.lastName});
}
