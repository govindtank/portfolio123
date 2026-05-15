import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  // Accent color name identifier
  String _accentName = 'Ocean';

  bool get isDarkMode => _isDarkMode;
  String get accentName => _accentName;

  // Map of accent names to primary colors
  static const Map<String, Color> accentColors = {
    'Ocean': Color(0xFF0066FF),
    'Emerald': Color(0xFF00C49A),
    'Royal': Color(0xFF9F44D3),
    'Sunset': Color(0xFFFF5E57),
  };

  Color get accentColor => accentColors[_accentName] ?? accentColors['Ocean']!;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  // Change accent color
  void setAccent(String name) {
    if (accentColors.containsKey(name) && _accentName != name) {
      _accentName = name;
      notifyListeners();
    }
  }
}
