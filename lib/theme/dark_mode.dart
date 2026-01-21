import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.blue.shade400,
    secondary: Colors.blue.shade600,
    tertiary: Colors.amber.shade400,
    inversePrimary: Colors.blue.shade100,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardColor: Colors.grey.shade800,
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white70,
        displayColor: Colors.white,
      ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    contentTextStyle: const TextStyle(color: Colors.white),
  ),
);
