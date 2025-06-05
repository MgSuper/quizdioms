import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF316E79);
  static const Color secondary = Color(0xFFD8E2E4);

  static const LinearGradient scaffoldGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.transparent, // handled via gradient container

  // TEXT STYLES
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    headlineLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyMedium: const TextStyle(fontSize: 16),
    labelSmall: const TextStyle(fontSize: 12, color: Colors.grey),
  ),

  // CARD
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(12),
  ),

  // ICON
  iconTheme: const IconThemeData(
    color: AppColors.primary,
    size: 24,
  ),

  // TEXTFORMFIELD
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: const TextStyle(color: AppColors.primary),
  ),

  // LIST TILE
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    iconColor: AppColors.primary,
    textColor: Colors.black87,
  ),
);

// class AppTheme {
//   static final light = ThemeData(
//       brightness: Brightness.light,
//       colorScheme: ColorScheme.light(
//         primary: Color(0xFF316E79),
//         secondary: Colors.amber,
//         error: Colors.red,
//       ),
//       scaffoldBackgroundColor: Colors.white,
//       appBarTheme: AppBarTheme(
//         backgroundColor: Color(0xFF316E79),
//         foregroundColor: Color(0xFFFFFFFF),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.teal.shade100,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       ),
//       cardTheme: CardTheme(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       textTheme: TextTheme(
//         bodyLarge: TextStyle(
//           color: Color(0xFFD8E2E4),
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//         bodyMedium: TextStyle(
//           color: Color(0xFFD8E2E4),
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         bodySmall: TextStyle(
//           color: Color(0xFFD8E2E4),
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//         ),
//       ));
// }
