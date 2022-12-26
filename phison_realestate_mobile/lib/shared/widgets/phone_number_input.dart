import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

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
      decoration: const InputDecoration(
        hintText: 'Phone Number',
        counterText: '',
      ),
      initialCountryCode: 'ET',
      onChanged: (phone) {},
    );
  }
}
