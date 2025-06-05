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
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFFD8E2E4),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFD8E2E4),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: Color(0xFFD8E2E4),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ));
}
