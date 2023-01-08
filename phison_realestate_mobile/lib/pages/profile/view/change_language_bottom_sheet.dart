import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Language',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const _MenuOption(
              label: 'English',
              icon: Icons.language,
            ),
            const SizedBox(
              height: 8.0,
            ),
            const _MenuOption(
              label: 'Amharic',
              icon: Icons.language,
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const _MenuOption({
    required this.label,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        color: isSelected ? PhisonColors.orange.shade900 : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(
              4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.6),
              borderRadius: BorderRadius.circular(
                32.0,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
