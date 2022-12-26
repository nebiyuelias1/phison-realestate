import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Create Account'),
    );
  }
}
