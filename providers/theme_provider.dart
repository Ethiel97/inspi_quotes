import 'package:flutter/material.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/local_storage.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';

class ThemeProvider with ChangeNotifier {
  final String _themeMode = 'THEME_MODE';
  String? _currentTheme;
  ThemeData? _themeData;

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: textStyle.fontFamily,
    backgroundColor: screenBackgroundColor,
    scaffoldBackgroundColor: screenBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyText1: textStyle.apply(
        color: Colors.white,
      ),
      bodyText2: textStyle.apply(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ).copyWith(secondary: accentColor),
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: textStyle.fontFamily,
    backgroundColor: whiteBackgroundColor.darken(2),
    scaffoldBackgroundColor: whiteBackgroundColor,
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(color: screenBackgroundColor),
    textTheme: TextTheme(
      bodyText1: textStyle.apply(
        color: screenBackgroundColor,
      ),
      bodyText2: textStyle.apply(
        color: screenBackgroundColor,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    ).copyWith(
      secondary: accentColor,
    ),
  );

  ThemeData? get theme => _themeData;

  String? get currentTheme => _currentTheme;

  ThemeProvider() {
    LocalStorage.getData(_themeMode).then((value) {
      print("VALUE $value");
      switch (value?.toString() ?? 'dark') {
        case 'light':
          _themeData = _lightTheme;
          _currentTheme = value;
          break;
        case 'dark':
          _themeData = _darkTheme;
          _currentTheme = value;
          break;
      }
      notifyListeners();
    }).catchError((e) => print(e));
  }

  void setDarkMode() {
    _themeData = _darkTheme;
    _currentTheme = 'dark';
    LocalStorage.saveData(_themeMode, _currentTheme);
    notifyListeners();
  }

  void toggleMode() {
    if (_currentTheme == 'dark') {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  void setLightMode() {
    _themeData = _lightTheme;
    _currentTheme = 'light';
    LocalStorage.saveData(_themeMode, _currentTheme);
    notifyListeners();
  }
}
