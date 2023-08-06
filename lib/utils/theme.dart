import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  unselectedWidgetColor: const Color(0xFF9AAC3D),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9AAC3D),
    onPrimary: Colors.white,
    secondary: Color(0xFF3C3C3E),
    onSecondary: Colors.white,
    tertiary: Color(0xFFCFCFCF),
    onTertiary: Colors.grey,
    background: Color(0xFFFAFAFA),
    onBackground: Color(0xFF2A6494),
    error: Color(0xFF9AAC3D),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF2A6494),
    outline: Color(0xFF3EB8D4),
  ).copyWith(
    onPrimaryContainer: const Color(0xFF2A6494).withOpacity(0.1),
  ),
  fontFamily: 'VisbyRoundCF',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3C3C3E)),
    headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3C3C3E)),
    bodyLarge: TextStyle(fontSize: 18.0, color: Color(0xFF3C3C3E)),
    bodyMedium: TextStyle(fontSize: 16.0, color: Color(0xFF3C3C3E)),
    bodySmall: TextStyle(fontSize: 14.0, color: Color(0xFF3C3C3E)),
  ),
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFF8F8F8),
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: const TextStyle(
        color: Color(0xFF9AAC3D),
        fontSize: 14.0,
        fontWeight: FontWeight.normal),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Color(0xFF9AAC3D), width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Color(0xFFCFCFCF),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Color(0xFFCFCFCF),
        width: 1.0,
      ),
    ),
    labelStyle: const TextStyle(fontSize: 16.0, color: Color(0xFFCFCFCF)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      )),
  iconTheme:
  const IconThemeData(color: Colors.black, size: 24),
  dividerTheme: const DividerThemeData(color: Color(0xFFEFEFEF)),
  progressIndicatorTheme:
  const ProgressIndicatorThemeData(color: Colors.black),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF9AAC3D),
    contentTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => const Color(0xFF9AAC3D)),
  ),

);
