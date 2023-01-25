part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._(
      {required this.status, this.user = User.empty, this.authToken});

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final String? authToken;

  AppState copyWith({String? authToken, AppStatus? status, User? user}) =>
      AppState._(
        status: status ?? this.status,
        authToken: authToken ?? this.authToken,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [status, user, authToken];
}
