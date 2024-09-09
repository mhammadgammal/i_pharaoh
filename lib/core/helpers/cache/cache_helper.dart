import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  SharedPreferences sharedPreferences;

  CacheHelper(this.sharedPreferences);

  Future<bool> putString(String key, String value) async => sharedPreferences.setString(key, value);
  String? getString(String key) => sharedPreferences.getString(key);

  Future<bool> putBool(String key, bool value) async => sharedPreferences.setBool(key, value);
  bool? getBool(String key) => sharedPreferences.getBool(key);

}