import 'package:flutter/material.dart';

Color light = const Color(0xFFECEFF4);
Color dark = const Color(0xFF000000);

List<ThemeData> getThemes() {
  return [
    // Dark theme
    ThemeData(
      colorScheme: const ColorScheme.highContrastDark(),
      scaffoldBackgroundColor: dark,
      dividerTheme: DividerThemeData(
        color: dark,
        thickness: 4,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: dark,
        iconTheme: IconThemeData(color: light),
      ),
    ),
    // Light theme
    ThemeData(
      colorScheme: const ColorScheme.highContrastLight(),
      scaffoldBackgroundColor: light,
      dividerTheme: DividerThemeData(
        color: light,
        thickness: 4,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: light,
        iconTheme: IconThemeData(color: dark),
      ),
    ),
  ];
}
