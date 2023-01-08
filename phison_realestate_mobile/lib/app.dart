// Flutter imports:
import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/main/view/main_page.dart';

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
      home: const MainPage(),
    );
  }
}
