import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color primaryColor = Colors.black87;
  static const Color accentColor = Colors.yellowAccent;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color inputFillColor = Color(0xFFF0F0F0);
  static const Color buttonColor = Colors.blueAccent;
  static const Color cancelButtonColor = Colors.grey;
  static const Color textColor = Colors.black87;
  static const Color placeholderColor = Colors.black38;

  // Typography
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle placeholderText = TextStyle(
    fontSize: 16,
    color: placeholderColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle cancelButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  // Input decoration
  static InputDecoration inputDecoration(String hintText) => InputDecoration(
    hintText: hintText,
    hintStyle: placeholderText,
    filled: true,
    fillColor: inputFillColor,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  // ThemeData
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      background: backgroundColor,
      onBackground: textColor,
      surface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: textColor,
      elevation: 0,
      titleTextStyle: headline,
      iconTheme: IconThemeData(color: textColor),
    ),
    textTheme: TextTheme(
      headlineLarge: headline,
      titleLarge: subheading,
      bodyLarge: bodyText,
      bodyMedium: placeholderText,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFillColor,
      hintStyle: placeholderText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: buttonText,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        textStyle: cancelButtonText,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: buttonColor,
      foregroundColor: Colors.white,
    ),
  );
}
