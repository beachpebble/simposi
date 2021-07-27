import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/auth_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository authManager, required ProfileRepository profileRepository})
      : _authManager = authManager,_profileRepository = profileRepository,
        super(AuthenticationLoading());

  final AuthRepository _authManager;
  final ProfileRepository _profileRepository;

  late MasterData masterData;

  String? get token => _authManager.jwt;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is ReloadAuthEvent) {
      yield AuthenticationLoading();
      await _authManager.loadAuth();
      try {
        MasterData mData = await _profileRepository.getMasterData();
        masterData = mData;

      } catch (e) {
        yield AuthenticatedError();
        return;
      }
      if (_authManager.authorized) {
        await _profileRepository.refreshProfile();
        yield Authenticated();
      } else {
        yield NotAuthenticated();
      }
    } else if (event is LogOut) {
      _authManager.logout();
      yield NotAuthenticated();
    } else if (event is LoggedOut) {
      yield NotAuthenticated();
    } else if (event is SaveAuthEvent) {
      _authManager.saveAuth(event.token);
      yield Authenticated();
    }
  }
}
