import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phison_realestate_mobile/pages/create_account/view/create_account_page.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Login To Your Account'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Login by filling the following information'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _PhoneNumberInput(),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Continue'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'or',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateAccountPage(),
                  ),
                );
              },
              child: const Text(
                'Create your account',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
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
