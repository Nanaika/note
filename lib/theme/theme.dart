import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  dividerTheme: const DividerThemeData(color: Colors.transparent),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Color.fromARGB(255, 42, 42, 42),
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
  dividerTheme: const DividerThemeData(color: Colors.transparent),
);
