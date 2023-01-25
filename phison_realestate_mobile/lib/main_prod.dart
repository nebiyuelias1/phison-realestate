// Package imports:
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:phison_realestate_mobile/start_app.dart';

Future<void> main() async {
  FlavorConfig(
    variables: {
      "baseUrl": "https://phison-realestate.com",
    },
  );

  await startApp();
}
