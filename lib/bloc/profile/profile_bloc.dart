import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/emergency_contact.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/model/profile.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late StreamSubscription authSubscription;
  final ProfileRepository _profileRepository;
  late MasterData masterData;

  Profile? _currentProfile;

  ProfileBloc(AuthenticationBloc authBloc, ProfileRepository profileRepository)
      : _profileRepository = profileRepository,
        super(ProfileNotLoaded()) {
    if (authBloc.state is Authenticated) {
      add(ProfileReload());
    }
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
          _currentProfile = await _profileRepository.refreshProfile();
          emit(ProfileLoaded(_currentProfile!));
        } catch (e) {
          emit(ProfileLoadError(e));
        }
      }
    });

    on<ProfileUpdateMainFields>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          String? newPath;
          if (event.filePath != null) {
            newPath =
                await profileRepository.uploadProfilePhoto(event.filePath!);
          }
          String? newPhone =
              (profileRepository.profile.userPhone != event.phone &&
                      event.phone != null &&
                      (event.phone?.isNotEmpty ?? false))
                  ? event.phone
                  : null;
          //if we want to change phone first check it it exists
          if (newPhone != null) {
            await profileRepository.userNotExist(phone: newPhone);
          }

          _currentProfile = await profileRepository.updateProfile(
              name: event.name,
              filepath: newPath,
              phone: newPhone,
              facebook: event.facebook,
              instagram: event.instagram,
              linkedin: event.linkedin);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateIndentifyAs>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateProfileGender(
              gender: event.gender, lgbt: event.isLgbt);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateGeneration>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateProfileGenerations(
              generation: event.generation);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateInterests>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateProfileInterests(
              interests: event.interests.map((e) => e.id).toList());
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateLocation>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateProfileLocation(
              latitude: event.latitude,
              longitude: event.longitude,
              range: event.range);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateIncome>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateProfileIncome(
              earnings: event.earnings.map((e) => e.id).toList());
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateEmergencyContact>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile =  await profileRepository.updateEmergencyContact(contact: EmergencyContact(event.name, event.phone));
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateWantToMeetGeneration>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile =  await profileRepository.updateWantToMeetGenerations(
              generations: event.generations);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateWantToMeetIncome>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile =  await profileRepository.updateWantToMeetIncome(
              earnings: event.earnings);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
        }
      }
    });

    on<ProfileUpdateWantToMeetGender>((event, emit) async {
      if (authBloc.state is Authenticated && _currentProfile != null) {
        emit(ProfileEditLoading(_currentProfile!));
        try {
          _currentProfile = await profileRepository.updateWantToMeetGender(gender: event.gender.toList(), lgbt: event.isLgbt);
          emit(ProfileEditSuccess(_currentProfile!));
        } catch (e) {
          emit(ProfileEditError(_currentProfile!, e));
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
