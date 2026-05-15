import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getInt(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future<void> setInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<String?> getString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> setString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<void> remove(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

