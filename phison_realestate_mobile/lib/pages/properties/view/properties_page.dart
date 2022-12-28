import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: 'Our Properties',
        hideLeading: true,
      ),
      body: const Text('Properties'),
    );
  }
}
