import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:phison_realestate_mobile/shared/widgets/phone_number_input.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Create Account'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
                'Create your account by filling the following information'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: PhoneNumberInput(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _NameInput(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _EmailInput(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        hintText: 'Name',
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        hintText: 'Email',
      ),
    );
  }
}
