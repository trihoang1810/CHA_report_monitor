import 'package:shared_preferences/shared_preferences.dart';

class UsernamePreferences {
  static SharedPreferences _preferences;
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername(String username) async {
    return await _preferences
        .setString('username', username);
  }

  static String getUsername() => _preferences.getString('username');
}
