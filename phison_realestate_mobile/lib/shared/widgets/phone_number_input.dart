import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../generated/l10n.dart';

class PhoneNumberInput extends StatelessWidget {
  final ValueChanged<PhoneNumber>? onChanged;
  const PhoneNumberInput({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      key: key,
      showCountryFlag: false,
      dropdownIcon: const Icon(
        Icons.phone_outlined,
        color: Colors.black,
      ),
      flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 8.0),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: S.of(context).phoneNumber,
        counterText: '',
      ),
      initialCountryCode: 'ET',
      onChanged: onChanged,
    );
  }
}
