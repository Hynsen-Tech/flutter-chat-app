import 'package:flutter/material.dart';

Color colorBasic = Color(0xff3097ff);

class ThemeBasic {
  ThemeData themeData = ThemeData().copyWith(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      foregroundColor: colorBasic,
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 11),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: colorBasic,
        foregroundColor: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      prefixIconColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: colorBasic,
    ),
    appBarTheme: AppBarTheme(
      color: colorBasic,
      foregroundColor: Colors.white,
    ),
  );
}
