part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppTokenChanged extends AppEvent {
  final String? token;

  const AppTokenChanged(this.token);

  @override
  List<Object?> get props => [token];
}
