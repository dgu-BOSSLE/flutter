import 'dart:io';  // File 클래스를 사용하기 위해 dart:io를 import
import 'package:shared_preferences/shared_preferences.dart';

class GlobalVariables {
  static bool? shouldCallApi;
  static File? selectedImage;
  static bool syncWeather = true;
  static bool sunny = true;
  static bool rainy = true;
  static bool rainyHard = true;
  static bool snowy = true;
  static double rainSliderValue = 50;
  static double snowSliderValue = 50;
  static double snowSpeedValue = 1;

  static Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    shouldCallApi = prefs.getBool('shouldCallApi') ?? false;

    syncWeather = prefs.getBool('syncWeather') ?? true;
    sunny = prefs.getBool('sunny') ?? true;
    rainy = prefs.getBool('rainy') ?? true;
    rainyHard = prefs.getBool('rainyHard') ?? true;
    snowy = prefs.getBool('snowy') ?? true;
    rainSliderValue = prefs.getDouble('rainSliderValue') ?? 50;
    snowSliderValue = prefs.getDouble('snowSliderValue') ?? 50;
    snowSpeedValue = prefs.getDouble('snowSpeedValue') ?? 1;

    String? imagePath = prefs.getString('selectedImagePath');
    if (imagePath != null) {
      selectedImage = File(imagePath);  // 저장된 경로를 사용하여 File 객체를 생성
    }
  }

  static Future<void> setPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('shouldCallApi', shouldCallApi!);

    prefs.setBool('syncWeather', syncWeather);
    prefs.setBool('sunny', sunny);
    prefs.setBool('rainy', rainy);
    prefs.setBool('rainyHard', rainyHard);
    prefs.setBool('snowy', snowy);
    prefs.setDouble('rainSliderValue', rainSliderValue);
    prefs.setDouble('snowSliderValue', snowSliderValue);
    prefs.setDouble('snowSpeedValue', snowSpeedValue);

    // selectedImage의 경우 File의 경로만 저장
    if (selectedImage != null) {
      prefs.setString('selectedImagePath', selectedImage!.path);
    }
  }

  static Future<void> setShouldCallApi(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('shouldCallApi', value);
    shouldCallApi = value;
  }
}
