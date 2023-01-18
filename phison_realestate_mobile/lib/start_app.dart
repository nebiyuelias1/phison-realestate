import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/app/view/app.dart';
import 'repositories/authentication_repository/authentication_repository.dart';

startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}
