import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _ProfilePhoto(),
              SizedBox(
                height: 8.0,
              ),
              _ProfileItem(
                label: '+251912345678',
                icon: Icons.phone_outlined,
              ),
              SizedBox(
                height: 8.0,
              ),
              _ProfileItem(
                label: 'Jhon Doe',
                icon: Icons.person_outline,
              ),
              SizedBox(
                height: 8.0,
              ),
              _ProfileItem(
                label: 'jhondoe@gmail.com',
                icon: Icons.email_outlined,
              ),
              SizedBox(
                height: 8.0,
              ),
              _ProfileItem(
                label: 'Change Language',
                icon: Icons.language,
              ),
              SizedBox(
                height: 16.0,
              ),
              _LogoutButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: PhisonColors.purple.shade900,
        borderRadius: BorderRadius.circular(48.0),
      ),
      child: const Icon(
        Icons.person_outlined,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const _ProfileItem({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text('Logout'),
    );
  }
}
