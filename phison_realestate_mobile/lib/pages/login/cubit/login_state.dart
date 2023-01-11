part of 'login_cubit.dart';

class LoginState extends Equatable {
  final PhoneNumber phoneNumber;
  final FormzStatus status;
  final String? error;

  const LoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  LoginState copyWith(
      {PhoneNumber? phoneNumber, FormzStatus? status, String? error}) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, status, error];
}
