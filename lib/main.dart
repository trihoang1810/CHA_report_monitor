import 'package:flutter/material.dart' as mat;
import 'package:mobile_app/utils/password_preferences.dart';
import 'package:mobile_app/utils/username_preferences.dart';

import 'my_app.dart';

void main() async {
  mat.WidgetsFlutterBinding.ensureInitialized();
  await UsernamePreferences.init();
  await PasswordPreferences.init();
  mat.runApp(MyApp());
}
