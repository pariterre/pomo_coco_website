import 'package:flutter/material.dart';

class ThemeManager {
  ///
  /// Prepare the singleton instance
  ///
  static final ThemeManager _instance = ThemeManager._internal();
  static ThemeManager get instance => _instance;
  ThemeManager._internal();

  ///
  /// Theme colors
  ///
  final titleColor = const Color.fromARGB(255, 84, 4, 95);
  final primaryColor = const Color.fromARGB(255, 193, 240, 251);
  final secondaryColor = const Color.fromARGB(255, 249, 206, 238);
  final boxBackgroundColor = const Color.fromARGB(255, 230, 102, 213);
  final colorButtonSelected = const Color.fromARGB(255, 243, 44, 193);
  final colorButtonUnselected = const Color.fromARGB(255, 249, 206, 238);

  ///
  /// Theme text
  ///
  final _textTheme = const TextTheme(
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'BebasNeue',
        fontSize: 28),
    titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'BebasNeue',
        fontSize: 20),
    titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'BebasNeue',
        fontSize: 18),
    bodyMedium:
        TextStyle(color: Colors.black, fontFamily: 'Nirmala', fontSize: 16),
  );

  ///
  /// Theme data
  ///
  ThemeData get themeData => ThemeData(textTheme: _textTheme);
}
