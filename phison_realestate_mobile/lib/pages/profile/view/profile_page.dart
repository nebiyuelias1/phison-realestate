import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: 'My Profile',
        hideLeading: true,
      ),
      body: const Text('Profile'),
    );
  }
}
