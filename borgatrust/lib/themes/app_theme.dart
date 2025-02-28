import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF0A5F44), // Deep teal
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFF26C6DA), // Bright cyan
      background: const Color(0xFFECEFF1), // Light gray-blue
    ),
    scaffoldBackgroundColor: const Color(0xFFECEFF1),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A5F44),
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:nst  Color(0xFF26C6DA),
        foregroundColor: Colors.white,
        shape: coRoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}