import 'package:flutter/material.dart';

class AppTheme {
  static const Color green = Color(0xFF3A8A3F);
  static const Color greenLight = Color(0xFF5DB462);
  static const Color greenBg = Color(0xFFEAF5EA);
  static const Color orange = Color(0xFFE8631A);
  static const Color orangeLight = Color(0xFFF28C3A);
  static const Color orangeBg = Color(0xFFFEF0E6);
  static const Color dark = Color(0xFF1A1A2E);
  static const Color textMuted = Color(0xFF7A8598);
  static const Color border = Color(0xFFE8EDF2);
  static const Color background = Color(0xFFF4F6FA);
  static const Color cardBg = Color(0xFFFFFFFF);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        scaffoldBackgroundColor: background,
        fontFamily: 'Nunito',
        appBarTheme: const AppBarTheme(
          backgroundColor: cardBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: dark),
          titleTextStyle: TextStyle(
            color: dark,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            fontFamily: 'Nunito',
          ),
        ),
        cardTheme: CardThemeData(
          color: cardBg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: border),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardBg,
          elevation: 8,
        ),
      );
}
