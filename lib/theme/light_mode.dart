import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.light(
  surface: Colors.white,
  primary: Colors.grey.shade600,
  secondary: Colors.grey.shade400,
  tertiary: Colors.amber.shade600,
  inversePrimary: Colors.white,
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.inversePrimary,
    elevation: 0,
  ),
  cardColor: Colors.white,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey.shade900,
        displayColor: Colors.grey.shade900,
      ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.inversePrimary,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightColorScheme.primary,
    contentTextStyle: TextStyle(color: lightColorScheme.inversePrimary),
  ),
);
