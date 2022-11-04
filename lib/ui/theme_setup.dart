import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(
      colorScheme: const ColorScheme.highContrastLight(
        secondary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFF2F3132),
      ),
      scaffoldBackgroundColor: const Color(0xFFECEFF4),
    ),
    ThemeData(
      colorScheme: const ColorScheme.highContrastDark(
        secondary: Color(0xFF363738),
        onSecondary: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFF2F3132),
    ),
  ];
}
