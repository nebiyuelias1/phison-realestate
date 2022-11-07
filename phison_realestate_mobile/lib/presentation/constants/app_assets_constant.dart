// Flutter imports:
import 'package:flutter/material.dart';

class PhisonColors {
  //Primary colors
  static const Color primaryColor = Color(0xff64378F); //update it
  static const Color secondaryColor = Color(0xfff48120);
  static const Color lightBackground = Color(0xffF7F7F7);

  static const MaterialColor primarySwatch =
      MaterialColor(0xff64378F, <int, Color>{
    100: Color.fromRGBO(100, 55, 143, 0.2),
    300: Color.fromRGBO(100, 55, 143, 0.4),
    500: Color.fromRGBO(100, 55, 143, 0.6),
    700: Color.fromRGBO(100, 55, 143, 0.8),
    900: Color(0xff000000),
  });
}

class PhisonIcons {
  //Icons path
  static const String hamsaLogo = 'assets/icons/commpass.svg';
  static const String charityIcon = 'assets/icons/credit-card.svg';
  static const String educationIcon = 'assets/icons/home-gray.svg';
  static const String healthIcon = 'assets/icons/home.svg';
  static const String optionsIcon = 'assets/icons/logo.svg';
  static const String balanceIcon = 'assets/icons/phone.svg';
  static const String paymentIcon = 'assets/icons/user-black.svg';
  static const String editIcon = 'assets/icons/user-white.svg';
  // static const String moreIcon = 'assets/icons/more.svg';
}
