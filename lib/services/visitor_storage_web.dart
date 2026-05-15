import 'dart:html' as html;

Future<int?> getInt(String key) async {
  final value = html.window.localStorage[key];
  if (value == null) return null;
  return int.tryParse(value);
}

Future<void> setInt(String key, int value) async {
  html.window.localStorage[key] = value.toString();
}

Future<String?> getString(String key) async {
  return html.window.localStorage[key];
}

Future<void> setString(String key, String value) async {
  html.window.localStorage[key] = value;
}

Future<void> remove(String key) async {
  html.window.localStorage.remove(key);
}

