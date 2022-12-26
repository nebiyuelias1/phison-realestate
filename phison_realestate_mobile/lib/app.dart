// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'welcome/view/welcome_page.dart';

//project imports:
import 'shared/theme/phison_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PHISON',
      theme: PhisonTheme.lightTheme,
      home: const WelcomePage(),
    );
  }
}
