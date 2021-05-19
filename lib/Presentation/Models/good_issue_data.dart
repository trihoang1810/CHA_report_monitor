class Employee {
  String employeeId;
  String firstName;
  String lastName;
  Employee({this.employeeId, this.firstName, this.lastName});
  factory Employee.fromJson(dynamic jsonObject) {
    return Employee(
        employeeId: jsonObject['employeeId'],
        firstName: jsonObject['firstName'],
        lastName: jsonObject['lastName']);
  }
}
