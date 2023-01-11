import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/form_inputs/phone_number.dart';
import 'package:phison_realestate_mobile/repositories/authentication_repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(const LoginState());

  void phoneNumberChanged(String phoneNumber) {
    final phoneInput = PhoneNumber.dirty(phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneInput, status: Formz.validate([phoneInput])));
  }

  Future<void> loginFormSubmitted() async {
    if (!state.status.isValidated) {
      return;
    }

    try {
      emit(
        state.copyWith(status: FormzStatus.submissionInProgress),
      );
      await _authenticationRepository.verifyPhoneNumber(
        VerifyPhoneNumberParam(
          onCodeSent: () {
            emit(
              state.copyWith(status: FormzStatus.submissionSuccess),
            );
          },
          phoneNumber: state.phoneNumber.value,
          onFailure: (error) => emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              error: error,
            ),
          ),
        ),
      );
    } on VerifyPhoneNumberFailure {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          error: 'Something went wrong'));
    }
  }
}
