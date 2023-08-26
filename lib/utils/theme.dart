import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  unselectedWidgetColor: const Color(0xFF9AAC3D),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffcf661c),
    onPrimary: Colors.white,
    secondary: Color(0xff254675),
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
class AppSizes {
  static final khugeSpace = 0.029.sh;
  static const kbigSpace = 20.0;
  static const ksmallSpace = 10.0;

  static const kdividerHeight = 2.0;

  static const kradius = 20.0;
  static const kbuttonHeight = 56.0;
  static const ksmallImageSize = 70.0;
  static const kbigImageSize = 180.0;
  static final khugeImageSize = 220.ss;
  static const kiconSize = 24.0;
  static const kiconBackgroundSize = 54.0;
  static const kiconBackgroundRadius = 99.0;

  static const kshimmerTextHeight = 8.0;
  static const kshimmerTextWidth = 100.0;
  static final ktitleTextHeight = 23.s;

  static const kmarkerSizeExpanded = 55.0;
  static const kmarkerSizeShrinked = 38.0;

  static const ktimeLineIcon = 30.0;
  static const ktimelineDotSize = 15.0;

  static const kcardHeight = 150.0;




}