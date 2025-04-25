import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;

  ThemeMode get themeMode {
    return _darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  switchTheme() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}
