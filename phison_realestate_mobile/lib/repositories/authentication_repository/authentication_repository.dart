import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:phison_realestate_mobile/api/auth/auth_api_client.dart';

import '../../api/auth/models/register_user.dart';
import 'cache.dart';
import 'models/user.dart';

/// Thrown if during the sign up process if a failure occurs.
class VerifyPhoneNumberFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Thrown when trying to verify otp code.
class VerifyOtpFailure implements Exception {
  final String message;

  VerifyOtpFailure(this.message);
}

class VerifyPhoneNumberParam extends Equatable {
  final String phoneNumber;
  final VoidCallback onCodeSent;
  final ValueChanged<String> onFailure;

  const VerifyPhoneNumberParam({
    required this.onCodeSent,
    required this.phoneNumber,
    required this.onFailure,
  });

  @override
  List<Object?> get props => [phoneNumber, onCodeSent, onFailure];
}

class VerifyOtpParam extends Equatable {
  final String phoneNumber;
  final String email;
  final String name;
  final String smsCode;

  const VerifyOtpParam(
      {required this.phoneNumber,
      required this.email,
      required this.name,
      required this.smsCode});

  @override
  List<Object?> get props => [phoneNumber, email, name, smsCode];
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  late String _verificationId;

  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    AuthApiClient? authApiClient,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _client = authApiClient ?? AuthApiClient.create();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final AuthApiClient _client;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Verifies users phone number given [VerifyPhoneNumberParam] param.
  ///
  /// Throws a [VerifyPhoneNumberFailure] if an exception occurs.
  Future<void> verifyPhoneNumber(VerifyPhoneNumberParam param) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: param.phoneNumber,
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          param.onCodeSent();
        },
        verificationCompleted: (phoneAuthCredential) {
          _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (e) {
          var error = 'Something went wrong.';
          if (e.code == 'invalid-phone-number') {
            error = 'Invalid phone number.';
          } else if (e.code == 'captcha-check-failed') {
            error = 'Captcha check failed.';
          } else if (e.code == 'missing-phone-number') {
            error = 'Missing phone number';
          } else if (e.code == 'quota-exceeded') {
            error = 'Quota exceeded. Try again later.';
          } else if (e.code == 'user-disabled') {
            error = 'User disabled';
          } else if (e.code == 'too-many-requests') {
            error = 'Too many requests. Try again later.';
          }
          param.onFailure(error);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on Exception {
      throw VerifyPhoneNumberFailure();
    }
  }

  Future<void> verifyOtp(String smsCode) async {
    await _verifyOtp(smsCode);
  }

  Future<void> verifyOtpAndRegister(VerifyOtpParam param) async {
    await _verifyOtp(param.smsCode);
    final token = await _firebaseAuth.currentUser?.getIdToken();

    await _client.registerUser(
      RegisterUser(
        name: param.name,
        email: param.email,
        phoneNumber: param.phoneNumber,
        token: token!,
      ),
    );
  }

  Future<void> _verifyOtp(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    try {
      // Sign the user in (or link) with the credential
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      var message = 'Something went wrong';
      if (e.code == 'invalid-credential') {
        message = 'Credential has expired.';
      } else if (e.code == 'user-disabled') {
        message = 'User is disabled.';
      } else if (e.code == 'invalid-verification-code') {
        message = 'Invalid verification code.';
      } else if (e.code == 'invalid-verification-id') {
        message = 'Invalid verification ID.';
      }

      throw VerifyOtpFailure(message);
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
