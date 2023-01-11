import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/auth/auth_api_client.dart';
import 'package:phison_realestate_mobile/form_inputs/required_text.dart';
import 'package:phison_realestate_mobile/repositories/authentication_repository/authentication_repository.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit(this._authenticationRepository)
      : super(const VerifyOtpState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> verifyOtpFormSubmitted(
      {String? name, String? email, String? phoneNumber}) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final registerUser = name != null && email != null && phoneNumber != null;
      if (registerUser) {
        await _authenticationRepository.verifyOtpAndRegister(
          VerifyOtpParam(
              phoneNumber: phoneNumber,
              email: email,
              name: name,
              smsCode: state.otp.value),
        );
      } else {
        await _authenticationRepository.verifyOtp(state.otp.value);
      }

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on VerifyOtpFailure catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.message,
        ),
      );
    } on RegisterUserFailure {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          error: 'Something went wrong, try again!',
        ),
      );
    }
  }

  void smsChanged(String sms) {
    final otp = RequiredText.dirty(sms);
    emit(state.copyWith(otp: otp, status: Formz.validate([otp])));
  }
}
