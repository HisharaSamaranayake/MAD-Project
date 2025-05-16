import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _fontFamily = 'Default'; // Default, Serif, Monospace
  String _fontSize = 'Medium';    // Small, Medium, Large

  late SharedPreferences _prefs;

  bool get isDarkMode => _isDarkMode;
  String get fontFamily => _fontFamily;
  String get fontSize => _fontSize;

  SettingsProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await loadSettings();
  }

  Future<void> loadSettings() async {
    _isDarkMode = _prefs.getBool('darkMode') ?? false;
    _fontFamily = _prefs.getString('fontFamily') ?? 'Default';
    _fontSize = _prefs.getString('fontSize') ?? 'Medium';
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setFontFamily(String value) {
    _fontFamily = value;
    notifyListeners();
  }

  void setFontSize(String value) {
    _fontSize = value;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    await _prefs.setBool('darkMode', _isDarkMode);
    await _prefs.setString('fontFamily', _fontFamily);
    await _prefs.setString('fontSize', _fontSize);
  }

  Future<void> resetSettings() async {
    _isDarkMode = false;
    _fontFamily = 'Default';
    _fontSize = 'Medium';
    await saveSettings();
    notifyListeners();
  }

  TextTheme getTextTheme(Brightness brightness) {
    double scale;
    switch (_fontSize) {
      case 'Small':
        scale = 0.85;
        break;
      case 'Large':
        scale = 1.25;
        break;
      default:
        scale = 1.0;
    }

    String? font;
    switch (_fontFamily) {
      case 'Serif':
        font = 'Merriweather';
        break;
      case 'Monospace':
        font = 'RobotoMono';
        break;
      default:
        font = null;
    }

    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;

    return font == null
        ? base.apply(fontSizeFactor: scale)
        : base.apply(fontSizeFactor: scale, fontFamily: font);
  }
}
