import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomePageAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text('Home'),
          ],
        ),
      ),
    );
  }
}
