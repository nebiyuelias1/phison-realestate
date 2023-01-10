part of 'create_account_cubit.dart';

class CreateAccountState extends Equatable {
  const CreateAccountState({
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.name = const RequiredText.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  final Email email;
  final PhoneNumber phoneNumber;
  final RequiredText name;
  final FormzStatus status;
  final String? error;

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        name,
        status,
        error,
      ];

  CreateAccountState copyWith(
      {Email? email,
      PhoneNumber? phoneNumber,
      RequiredText? name,
      FormzStatus? status,
      String? error}) {
    return CreateAccountState(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
