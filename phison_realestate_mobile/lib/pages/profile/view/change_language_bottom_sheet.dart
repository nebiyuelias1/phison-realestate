import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phison_realestate_mobile/pages/app/bloc/bloc/app_bloc.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';

import '../../../generated/l10n.dart';

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
              S.of(context).chooseLanguage,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _MenuOption(
              label: S.of(context).english,
              icon: Icons.language,
              onTap: () {
                context.read<AppBloc>().add(
                      const ChangeAppLocaleRequested(LocaleOption.english),
                    );
              },
              isSelected:
                  context.read<AppBloc>().state.currentLocale?.languageCode ==
                      'en',
            ),
            const SizedBox(
              height: 8.0,
            ),
            _MenuOption(
              label: S.of(context).amharic,
              icon: Icons.language,
              isSelected:
                  context.read<AppBloc>().state.currentLocale?.languageCode ==
                      'am',
              onTap: () {
                context.read<AppBloc>().add(
                      const ChangeAppLocaleRequested(LocaleOption.amharic),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

typedef _MenuOptionGestureCallback = void Function();

class _MenuOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final _MenuOptionGestureCallback onTap;

  const _MenuOption({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
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
      ),
    );
  }
}
