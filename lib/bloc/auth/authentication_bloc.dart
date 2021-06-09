import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/repository/auth_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository authManager})
      : _authManager = authManager,
        super(AuthenticationLoading());

  final AuthRepository _authManager;

  String? get token => _authManager.jwt;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is ReloadAuthEvent) {
      yield AuthenticationLoading();
      await _authManager.loadAuth();
      if (_authManager.authorized) {
        yield Authenticated();
      } else {
        yield NotAuthenticated();
      }
    } else if (event is LogOut) {
      _authManager.logout();
      yield NotAuthenticated();
    } else if (event is LoggedOut) {
      yield NotAuthenticated();
    }
  }
}
