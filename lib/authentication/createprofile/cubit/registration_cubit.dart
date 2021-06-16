import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit({required this.profileRepository})
      : super(RegistrationStageLoadingData());

  final ProfileRepository profileRepository;

  File? imageFile;
  String? name;
  String? phone;
  String? email;
  String? password;
  Gender? gender;
  Gender? wantToMeet;
  Set<Generation>? generations;
  Set<Earning>? earnings;
  Set<Interest>? interests;
  bool lgbt = false;
  double? latitude;
  double? longitude;
  double? range;
  late MasterData mData;

  Future<void> preload() async {
    emit(RegistrationStageLoadingData());
    try {
      MasterData mData = await profileRepository.getMasterData();
      this.mData = mData;
      emit(RegistrationStage1());
    } catch (e) {
      emit(RegistrationStageLoadingDataError(e));
    }
  }

  Future<void> firstStage({
    required String file,
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegistrationStage1Loading());
    try {
      String? path = await profileRepository.uploadAvatar(file);
      if (path != null) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.password = password;
        emit(RegistrationStage2());
      } else {
        emit(RegistrationStage1Error("File is not loaded"));
      }
    } catch (e) {
      emit(RegistrationStage1Error(e));
    }
  }

  Future<void> stage2({
    required Gender gender,
    required bool lgbt,
  }) async {
    this.gender = gender;
    this.lgbt = lgbt;
    emit(RegistrationStage3(gender));
  }

  Future<void> stage3({
    required Gender wantToMeet,
  }) async {
    this.wantToMeet = wantToMeet;
    emit(RegistrationStage4());
  }

  Future<void> stage4({
    required Set<Generation> generations,
  }) async {
    this.generations = generations;
    emit(RegistrationStage5());
  }

  Future<void> stage5({
    required Set<Earning> earnings,
  }) async {
    this.earnings = earnings;

    emit(RegistrationStage6(mData.interests));
  }

  Future<void> stage6({
    required Set<Interest> interests,
  }) async {
    this.interests = interests;

    emit(RegistrationStage7());
  }

  Future<void> stage7({
    required double latitude,
    required double longitude,
    required double range,
  }) async {
    this.latitude = latitude;
    this.longitude = longitude;
    this.range = range;
    emit(RegistrationStage8());
  }
}
