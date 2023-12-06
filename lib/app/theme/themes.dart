import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    // fontFamily: 'AlSharkTitle',
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        titleTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
        )),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    )),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black26,
        )),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
  );
}
