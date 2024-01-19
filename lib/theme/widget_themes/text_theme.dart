import 'package:flutter/material.dart';


/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0,  color: Colors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,  color: Colors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,  color: Colors.black),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.black),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.black),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.black),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.black),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.black.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0,  color: Colors.black),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0,  color: Colors.black),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0,  color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,  color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,  color: Colors.white),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0,  color: Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0,  color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0,  color: Colors.white),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0,  color: Colors.white.withOpacity(0.5)),
  );
}
