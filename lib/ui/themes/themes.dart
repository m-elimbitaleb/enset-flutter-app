import 'package:flutter/material.dart';

class CustomThemes {
  static List<ThemeData> themes = [
    ThemeData(
      primarySwatch: Colors.teal,
      textTheme: const TextTheme(caption: TextStyle(color: Colors.red)),
    ),
    ThemeData(
      primarySwatch: Colors.deepOrange,
      textTheme: const TextTheme(caption: TextStyle(color: Colors.red)),
    ),
    ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(caption: TextStyle(color: Colors.red)),
    ),
  ];
}
