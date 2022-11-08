// Flutter imports:
import 'package:flutter/material.dart';

//project imports:
// import 'presentation/theme/phison_theme.dart';
import 'presentation/pages/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PHISON',
        // theme: PhisonTheme.lightTheme,
        home: WelcomePage());
  }
}
