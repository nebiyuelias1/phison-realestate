// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../constants/app_assets_constant.dart';
import 'phison_text_theme.dart';

mixin PhisonTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: PhisonColors.primaryColor,
      primaryColorLight: PhisonColors.primarySwatch,
      appBarTheme: const AppBarTheme(
          backgroundColor: PhisonColors.lightBackground, elevation: 0),
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
          backgroundColor: MaterialStateProperty.all(
            PhisonColors.purple.shade900,
          ),
          foregroundColor: MaterialStateProperty.all(
            PhisonColors.lightBackground,
          ),
        ),
      ),
    );
  }
}
