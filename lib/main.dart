import 'package:flutter/material.dart' as mat;
import 'package:mobile_app/utils/username_preferences.dart';

import 'my_app.dart';

void main() async {
  mat.WidgetsFlutterBinding.ensureInitialized();
  await UsernamePreferences.init();
  mat.runApp(MyApp());
}
