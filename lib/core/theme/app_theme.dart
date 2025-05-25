import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF316E79),
      secondary: Colors.amber,
      error: Colors.red,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF316E79),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade100,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
