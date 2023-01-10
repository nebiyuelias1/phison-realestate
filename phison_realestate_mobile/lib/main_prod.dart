// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:phison_realestate_mobile/repositories/authentication_repository/authentication_repository.dart';

// Project imports:
import 'pages/app/view/app.dart';

Future<void> main() async {
  FlavorConfig(
    variables: {
      "baseUrl": "https://phison-realestate.com",
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}
