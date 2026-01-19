import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
    foregroundColor: Colors.white,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white70,
        displayColor: Colors.white,
      ),
);
