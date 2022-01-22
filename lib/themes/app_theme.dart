import 'package:flutter/material.dart';

class AppThemes {
  static final appThemData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.deepOrange,
      accentColor: Colors.white,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
          ),
          bodyText2: TextStyle(color: Colors.deepPurpleAccent)),
    ),
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primarySwatch: Colors.teal,
      backgroundColor: Colors.black,
      textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(color: Colors.blueAccent)),
    )
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
