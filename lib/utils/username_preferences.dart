import 'package:shared_preferences/shared_preferences.dart';

class UsernamePreferences {
  static SharedPreferences _preferences;
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername(String username) async {
    final buffer = _preferences.getStringList('username-list');
    return await _preferences
        .setStringList('username-list', [...buffer, username]);
  }

  static List<String> getUsername() => _preferences.getStringList('username-list');
}
