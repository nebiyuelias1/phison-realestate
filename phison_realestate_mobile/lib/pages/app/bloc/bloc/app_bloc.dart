import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../../repositories/authentication_repository/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
    _authTokenSubscription =
        _authenticationRepository.authToken.listen(_onAuthTokenChanged);
    on<AppUserChanged>((event, emit) {
      emit(_mapUserChangedToState(event, state));
    });
    on<AppLogoutRequested>((event, emit) async {
      await _authenticationRepository.logOut();
    });
    on<AppTokenChanged>(
        ((event, emit) => emit(state.copyWith(authToken: event.token))));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  late final StreamSubscription<Future<String>?> _authTokenSubscription;

  void _onUserChanged(User user) => add(AppUserChanged(user));

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    final status = event.user.isNotEmpty
        ? AppStatus.authenticated
        : AppStatus.unauthenticated;
    return state.copyWith(status: status, user: event.user);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _authTokenSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthTokenChanged(Future<String>? event) async {
    final token = await event;
    add(AppTokenChanged(token ?? ''));
  }
}
