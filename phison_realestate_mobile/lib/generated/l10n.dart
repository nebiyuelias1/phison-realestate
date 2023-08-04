// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello, World!`
  String get title {
    return Intl.message(
      'Hello, World!',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Amharic`
  String get amharic {
    return Intl.message(
      'Amharic',
      name: 'amharic',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Failure`
  String get signUpFailure {
    return Intl.message(
      'Sign Up Failure',
      name: 'signUpFailure',
      desc: '',
      args: [],
    );
  }

  /// `Create your account by filling the following information`
  String get createYourAccountByFillingTheFollowingInformation {
    return Intl.message(
      'Create your account by filling the following information',
      name: 'createYourAccountByFillingTheFollowingInformation',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueStep {
    return Intl.message(
      'Continue',
      name: 'continueStep',
      desc: '',
      args: [],
    );
  }

  /// `Our Properties`
  String get ourProperties {
    return Intl.message(
      'Our Properties',
      name: 'ourProperties',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `🙁 No properties to show at the moment`
  String get noPropertiesToShowAtTheMoment {
    return Intl.message(
      '🙁 No properties to show at the moment',
      name: 'noPropertiesToShowAtTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `Featured Properties`
  String get featuredProperties {
    return Intl.message(
      'Featured Properties',
      name: 'featuredProperties',
      desc: '',
      args: [],
    );
  }

  /// `Login To Your Account`
  String get loginToYourAccount {
    return Intl.message(
      'Login To Your Account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login by filling the following information`
  String get loginByFillingTheFollowingInformation {
    return Intl.message(
      'Login by filling the following information',
      name: 'loginByFillingTheFollowingInformation',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get createYourAccount {
    return Intl.message(
      'Create your account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Properties`
  String get properties {
    return Intl.message(
      'Properties',
      name: 'properties',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get payments {
    return Intl.message(
      'Payments',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Payment Due`
  String get paymentDue {
    return Intl.message(
      'Payment Due',
      name: 'paymentDue',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `You have a notification.`
  String get youHaveANotification {
    return Intl.message(
      'You have a notification.',
      name: 'youHaveANotification',
      desc: '',
      args: [],
    );
  }

  /// `You have an upcoming payment scheduled for`
  String get youHaveAnUpcomingPaymentScheduledFor {
    return Intl.message(
      'You have an upcoming payment scheduled for',
      name: 'youHaveAnUpcomingPaymentScheduledFor',
      desc: '',
      args: [],
    );
  }

  /// `Villa`
  String get villa {
    return Intl.message(
      'Villa',
      name: 'villa',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `A 6-digit code has been sent to your sms`
  String get a6digitCodeHasBeenSentToYourSms {
    return Intl.message(
      'A 6-digit code has been sent to your sms',
      name: 'a6digitCodeHasBeenSentToYourSms',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Let's Find Your`
  String get letsFindYour {
    return Intl.message(
      'Let\'s Find Your',
      name: 'letsFindYour',
      desc: '',
      args: [],
    );
  }

  /// `Dream Home`
  String get dreamHome {
    return Intl.message(
      'Dream Home',
      name: 'dreamHome',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `A luxurious residential houses and apartments in Addis Ababa, Ethiopia.`
  String get aLuxuriousResidentialHousesAndApartmentsInAddisAbabaEthiopia {
    return Intl.message(
      'A luxurious residential houses and apartments in Addis Ababa, Ethiopia.',
      name: 'aLuxuriousResidentialHousesAndApartmentsInAddisAbabaEthiopia',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login`
  String get goToLogin {
    return Intl.message(
      'Go to Login',
      name: 'goToLogin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'am', countryCode: 'ET'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
