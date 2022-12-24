// Flutter imports:
import 'package:flutter/material.dart';

class PhisonColors {
  //Primary colors
  static const Color primaryColor = Color(0xff64378F); //update it
  static const Color secondaryColor = Color(0xfff48120);
  static const Color lightBackground = Color(0xffF7F7F7);
  static const Color lightGrayTextColor = Color(0xffFCFCFD);
  static const Color drakGrayTextColor = Color(0xFF252B5C);

  static const MaterialColor primarySwatch =
      MaterialColor(0xff64378F, <int, Color>{
    100: Color.fromRGBO(100, 55, 143, 0.2),
    300: Color.fromRGBO(100, 55, 143, 0.4),
    500: Color.fromRGBO(100, 55, 143, 0.6),
    700: Color.fromRGBO(100, 55, 143, 0.8),
    900: Color.fromRGBO(0, 0, 0, 1),
  });

  static const int _purplePrimaryValue = 0xFFa287bc;
  static const purple = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFe0d7e9),
      200: Color(0xFFd1c3dd),
      300: Color(0xFFc1afd2),
      400: Color(0xFFb29bc7),
      500: Color(_purplePrimaryValue),
      600: Color(0xFF9373b1),
      700: Color(0xFF835fa5),
      800: Color(0xFF744b9a),
      900: Color(0xFF64378f),
    },
  );

  static const int _orangePrimaryValue = 0xFFf8b379;
  static const orange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFfde6d2),
      200: Color(0xFFfcd9bc),
      300: Color(0xFFfbcda6),
      400: Color(0xFFfac090),
      500: Color(_orangePrimaryValue),
      600: Color(0xFFf7a763),
      700: Color(0xFFf69a4d),
      800: Color(0xFFf58e36),
      900: Color(0xFFf48120),
    },
  );
}

class PhisonIcons {
  //Icons path
  static const String phisonLogo = 'assets/icons/commpass.svg';
  static const String charityIcon = 'assets/icons/credit-card.svg';
  static const String educationIcon = 'assets/icons/home-gray.svg';
  static const String healthIcon = 'assets/icons/home.svg';
  static const String optionsIcon = 'assets/icons/logo.svg';
  static const String balanceIcon = 'assets/icons/phone.svg';
  static const String paymentIcon = 'assets/icons/user-black.svg';
  static const String editIcon = 'assets/icons/user-white.svg';
  // static const String moreIcon = 'assets/icons/more.svg';

}

class PhisonImages {
  //Images Path
  static const String welcomeImage = 'assets/images/welcomeImage.webp';
}
