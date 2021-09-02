import 'package:flutter/material.dart';

class MebookTheme {
  ThemeData get themeData => ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.cyan,
        fontFamily: 'TruenoRound',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
