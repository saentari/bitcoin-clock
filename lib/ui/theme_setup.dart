import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    // Light theme
    ThemeData(
      fontFamily: 'Economica',
      colorScheme: const ColorScheme.highContrastLight(
        secondary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFF2F3132),
      ),
      scaffoldBackgroundColor: const Color(0xFFECEFF4),
    ),
    // Dark theme
    ThemeData(
      fontFamily: 'Economica',
      colorScheme: const ColorScheme.highContrastDark(
        secondary: Color(0xFF1F1F1F),
        onSecondary: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFF000000),
    ),
  ];
}
