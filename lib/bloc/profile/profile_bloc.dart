import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  late StreamSubscription authSubscription;
  final ProfileRepository _profileRepository;
  late MasterData masterData;

  ProfileBloc(AuthenticationBloc authBloc,
      ProfileRepository profileRepository)
      :
        _profileRepository = profileRepository,
        super(ProfileNotLoaded()) {
    authSubscription = authBloc.stream.listen((state) {
      if (state is NotAuthenticated) {

      } else if (state is Authenticated) {
        add(ProfileReload());
      }
    });

    on<ProfileReload>((event, emit) async {
      if (authBloc.state is Authenticated) {
        emit(ProfileLoading());
        try {
          await _profileRepository.refreshProfile();
          emit(ProfileLoaded());
        } catch (e) {
          emit(ProfileLoadError(e));
        }
      }

    });

  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
