// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../constants/app_assets_constant.dart';
import 'phison_text_theme.dart';

mixin PhisonTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: PhisonColors.purple,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: phisonTextTheme,
      fontFamily: 'Poppins',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return PhisonColors.purple;
              }

              return PhisonColors.purple.shade900;
            },
          ),
          foregroundColor: MaterialStateProperty.all(
            PhisonColors.lightBackground,
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(16.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PhisonColors.orange, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.grey),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 48.0,
              vertical: 8.0,
            ),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
    );
  }
}
