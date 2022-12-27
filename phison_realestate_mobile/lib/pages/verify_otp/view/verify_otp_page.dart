import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Verify It\'s You'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'A 6-digit code has been sent to your sms',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _OtpInput(),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Verify'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Didn\'t receive the code?',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Resend Code'),
            )
          ],
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput();

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      fieldWidth: 50.0,
      focusedBorderColor: PhisonColors.orange,
      cursorColor: Colors.black,
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: (code) {
        //handle validation or checks here
      },
      decoration: const InputDecoration(
        hintText: '-',
        counterText: '',
      ),
      //runs when every textfield is filled
      onSubmit: (verificationCode) {}, // end onSubmit
      hasCustomInputDecoration: true,
    );
  }
}
