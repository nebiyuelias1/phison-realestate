import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';

import 'pages/app/view/app.dart';
import 'repositories/authentication_repository/authentication_repository.dart';

startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final propertiesRepository = PropertiesRepository();

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      propertiesRepository: propertiesRepository,
    ),
  );
}
