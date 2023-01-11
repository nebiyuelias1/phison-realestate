import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/form_inputs/phone_number.dart';
import 'package:phison_realestate_mobile/form_inputs/required_text.dart';

import '../../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../form_inputs/email.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit(this._authenticationRepository)
      : super(const CreateAccountState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.phoneNumber,
        state.name,
      ]),
    ));
  }

  void nameChanged(String value) {
    final name = RequiredText.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.phoneNumber,
        state.email,
      ]),
    ));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        phoneNumber,
        state.email,
        state.name,
      ]),
    ));
  }

  Future<void> createAccountFormSubmitted() async {
    if (!state.status.isValidated) return;

    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await _authenticationRepository.verifyPhoneNumber(
        VerifyPhoneNumberParam(
          onCodeSent: () {
            emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
            ));
          },
          phoneNumber: state.phoneNumber.value,
          onFailure: (message) {
            emit(
              state.copyWith(
                status: FormzStatus.submissionFailure,
                error: message,
              ),
            );
          },
        ),
      );
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
