import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phison_realestate_mobile/pages/profile/view/change_language_bottom_sheet.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

import '../../app/bloc/bloc/app_bloc.dart';

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
            children: [
              const _ProfilePhoto(),
              const SizedBox(
                height: 8.0,
              ),
              const _ProfileItem(
                label: '+251912345678',
                icon: Icons.phone_outlined,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const _ProfileItem(
                label: 'Jhon Doe',
                icon: Icons.person_outline,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const _ProfileItem(
                label: 'jhondoe@gmail.com',
                icon: Icons.email_outlined,
              ),
              const SizedBox(
                height: 8.0,
              ),
              _ProfileItem(
                label: 'Change Language',
                icon: Icons.language,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.0),
                      ),
                    ),
                    builder: (context) => const ChangeLanguageBottomSheet(),
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const _LogoutButton()
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
  final VoidCallback? onTap;

  const _ProfileItem({
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return OutlinedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            context.read<AppBloc>().add(AppLogoutRequested());
          },
          child: const Text('Logout'),
        );
      },
    );
  }
}
