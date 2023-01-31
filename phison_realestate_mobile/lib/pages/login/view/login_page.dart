import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/pages/create_account/view/create_account_page.dart';
import 'package:phison_realestate_mobile/pages/login/cubit/login_cubit.dart';
import 'package:phison_realestate_mobile/repositories/authentication_repository/authentication_repository.dart';
import 'package:phison_realestate_mobile/shared/constants/app_strings/login_strings_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_elevated_button.dart';

import '../../../shared/widgets/phone_number_input.dart';
import '../../verify_otp/view/verify_otp_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: LoginStrings.headingText),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
          }
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).push(
              VerifyOtpPage.route(),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(LoginStrings.subheadingText),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return PhoneNumberInput(
                    onChanged: (value) => context
                        .read<LoginCubit>()
                        .phoneNumberChanged(value.completeNumber),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return PhisonElevatedButton(
                  label: LoginStrings.continueBtnText,
                  showLoader: state.status.isSubmissionInProgress,
                  onPressed: state.status.isValidated &&
                          !state.status.isSubmissionInProgress
                      ? () {
                          context.read<LoginCubit>().loginFormSubmitted();
                        }
                      : null,
                );
              },
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
                LoginStrings.signupPageText,
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
