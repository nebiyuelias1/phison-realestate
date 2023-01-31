import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../shared/widgets/phison_elevated_button.dart';
import '../cubit/verify_otp_cubit.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key, this.email, this.phoneNumber, this.name});
  final String? email;
  final String? phoneNumber;
  final String? name;

  static Route route({
    String? email,
    String? phoneNumber,
    String? name,
  }) =>
      MaterialPageRoute(
        builder: (context) => VerifyOtpPage(
          email: email,
          name: name,
          phoneNumber: phoneNumber,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Verify It\'s You'),
      body: BlocProvider(
        create: (context) =>
            VerifyOtpCubit(context.read<AuthenticationRepository>()),
        child: BlocListener<VerifyOtpCubit, VerifyOtpState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
            } else if (state.status.isSubmissionSuccess) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          child: Padding(
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
                BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
                  builder: (context, state) {
                    return PhisonElevatedButton(
                      label: 'Verify',
                      onPressed: state.status.isValidated &&
                              !state.status.isSubmissionInProgress
                          ? () async {
                              await context
                                  .read<VerifyOtpCubit>()
                                  .verifyOtpFormSubmitted(
                                    name: name,
                                    email: email,
                                    phoneNumber: phoneNumber,
                                  );
                            }
                          : null,
                      showLoader: state.status.isSubmissionInProgress,
                    );
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // TODO: Implement Resend Otp logic
                /*
                const Text(
                  'Didn\'t receive the code?',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Resend Code'),
                )
                */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
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
          onSubmit: (verificationCode) {
            context.read<VerifyOtpCubit>().smsChanged(verificationCode);
          }, // end onSubmit
          hasCustomInputDecoration: true,
        );
      },
    );
  }
}
