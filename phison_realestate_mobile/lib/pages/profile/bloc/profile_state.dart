part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final PhisonUser? user;
  final FormzStatus status;
  final String? error;

  const ProfileState({
    this.user,
    this.status = FormzStatus.pure,
    this.error,
  });

  @override
  List<Object?> get props => [
        user,
        status,
        error,
      ];

  ProfileState copyWith({
    FormzStatus? status,
    PhisonUser? user,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
