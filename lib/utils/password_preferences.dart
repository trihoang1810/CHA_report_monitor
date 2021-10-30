import 'package:shared_preferences/shared_preferences.dart';

class PasswordPreferences {
  static SharedPreferences _preferences;
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setPassword(String password) async {
    return await _preferences
        .setString('password', password);
  }

  static String getPassword() => _preferences.getString('password');
}
