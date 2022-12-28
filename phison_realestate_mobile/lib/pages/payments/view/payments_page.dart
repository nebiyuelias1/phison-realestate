import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: 'Due Payments',
        hideLeading: true,
      ),
      body: const Text('Due Payments'),
    );
  }
}
