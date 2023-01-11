part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.error,
    this.otp = const RequiredText.pure(),
    this.status = FormzStatus.pure,
  });
  final RequiredText otp;
  final FormzStatus status;
  final String? error;

  @override
  List<Object?> get props => [otp, status, error];

  VerifyOtpState copyWith(
      {RequiredText? otp, FormzStatus? status, String? error}) {
    return VerifyOtpState(
      otp: otp ?? this.otp,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
