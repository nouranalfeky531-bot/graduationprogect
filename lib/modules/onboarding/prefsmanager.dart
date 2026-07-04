import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {

  static Future<void> setPrefs(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("intro_seen", state);
  }

  static Future<bool> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("intro_seen") ?? false;
  }
}