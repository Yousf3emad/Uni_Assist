import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // ignore: constant_identifier_names
  static const THEME_STATUS = "THEME_STATUS";
  bool _darkTheme = false;
  bool get getIsDarkTheme => _darkTheme;

  ThemeProvider() {
    getTheme();
  }

  //set ThemeValue(Dark or Light) to SharedPreference
  Future<void> setDarkTheme({
    required bool themeValue,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, themeValue);
    _darkTheme = themeValue;
    notifyListeners();
  }

  //get ThemeValue(Dark or Light) from SharedPreference
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(THEME_STATUS) ??
        false; //if return value == nul set is by false
    return _darkTheme;
  }
}
