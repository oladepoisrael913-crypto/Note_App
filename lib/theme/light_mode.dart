import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.blue.shade700,
    secondary: Colors.blue.shade400,
    tertiary: Colors.amber.shade600,
    inversePrimary: Colors.blue.shade900,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue.shade700,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardColor: Colors.white,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey.shade900,
        displayColor: Colors.grey.shade900,
      ),
);
