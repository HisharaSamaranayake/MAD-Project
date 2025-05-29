import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default settings
  ThemeMode _themeMode = ThemeMode.light;
  String _fontFamily = 'Default';
  double _fontSize = 16.0;
  Locale _locale = const Locale('en');

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get fontFamily => _fontFamily;
  double get fontSize => _fontSize;
  Locale get locale => _locale;

  // Toggle between light and dark theme
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Set font family
  void setFontFamily(String font) {
    _fontFamily = font;
    notifyListeners();
  }

  // Set font size with safety check
  void setFontSize(double size) {
    if (size != 14.0 && size != 16.0 && size != 18.0) {
      size = 16.0; // fallback to default
    }
    _fontSize = size;
    notifyListeners();
  }

  // Set locale by language code string
  void setLocale(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }

  // Reset all settings to default
  void resetSettings() {
    _themeMode = ThemeMode.light;
    _fontFamily = 'Default';
    _fontSize = 16.0;
    _locale = const Locale('en');
    notifyListeners();
  }
}







