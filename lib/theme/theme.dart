import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 255, 215, 0),
  ),
  dividerColor: Colors.white24,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white24),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);