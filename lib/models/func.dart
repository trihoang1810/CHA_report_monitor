import 'package:flutter/material.dart';

import 'login.dart';

void logout(BuildContext context) {
  employeeIdOverall = "";
  employeeFirstNameOverall = "";
  employeeLastNameOverall = "";
  while (Navigator.canPop(context)) {
    Navigator.pop(context);
    print("Đã pop");
  }
}
