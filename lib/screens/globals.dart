import 'package:shared_preferences/shared_preferences.dart';

class GlobalVariables {
  static bool? shouldCallApi;
  static Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    shouldCallApi = prefs.getBool('shouldCallApi') ??  false;
  }
  static Future<void> setShouldCallApi(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('shouldCallApi', value);
    shouldCallApi = value;
  }
}