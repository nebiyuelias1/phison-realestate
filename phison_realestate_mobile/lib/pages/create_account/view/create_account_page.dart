import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/pages/create_account/cubit/create_account_cubit.dart';
import 'package:phison_realestate_mobile/pages/verify_otp/view/verify_otp_page.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:phison_realestate_mobile/shared/widgets/phone_number_input.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: 'Create Account'),
      body: BlocProvider<CreateAccountCubit>(
        create: (context) => CreateAccountCubit(
          context.read<AuthenticationRepository>(),
        ),
        child: BlocListener<CreateAccountCubit, CreateAccountState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.error ?? 'Sign Up Failure')),
                );
            }

            if (state.status.isSubmissionSuccess) {
              Navigator.of(context).push(
                VerifyOtpPage.route(
                  email: state.email.value,
                  name: state.name.value,
                  phoneNumber: state.phoneNumber.value,
                ),
              );
            }
          },
          child: const _CreateAccountForm(),
        ),
      ),
    );
  }
}

class _CreateAccountForm extends StatelessWidget {
  const _CreateAccountForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
                'Create your account by filling the following information'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
                buildWhen: (previous, current) =>
                    previous.phoneNumber != current.phoneNumber,
                builder: (context, state) {
                  return PhoneNumberInput(
                    onChanged: (phone) =>
                        context.read<CreateAccountCubit>().phoneNumberChanged(
                              phone.completeNumber,
                            ),
                  );
                },
              ),
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
              child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status.isValidated &&
                            !state.status.isSubmissionInProgress
                        ? () {
                            context
                                .read<CreateAccountCubit>()
                                .createAccountFormSubmitted();
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.status.isSubmissionInProgress)
                          const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        const Text('Continue'),
                      ],
                    ),
                  );
                },
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
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (name) =>
              context.read<CreateAccountCubit>().nameChanged(name),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            hintText: 'Name',
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<CreateAccountCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black,
            ),
            hintText: 'Email',
          ),
        );
      },
    );
  }
}
