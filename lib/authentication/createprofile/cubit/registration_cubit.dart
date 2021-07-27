import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit({required this.profileRepository})
      : super(RegistrationInitial());

  final ProfileRepository profileRepository;

  File? imageFile;
  String? path;
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

  String? apiToken;

  void stage2({
    required Gender gender,
    required bool lgbt,
  }) {
    this.gender = gender;
    this.lgbt = lgbt;
  }

  void stage3({
    required Gender wantToMeet,
  }) {
    this.wantToMeet = wantToMeet;
  }

  void stage4({
    required Set<Generation> generations,
  }) async {
    this.generations = generations;
  }

  void stage5({
    required Set<Earning> earnings,
  }) async {
    this.earnings = earnings;
  }

  void stage6({
    required Set<Interest> interests,
  }) async {
    this.interests = interests;
  }

  void stage7({
    required double latitude,
    required double longitude,
    required double range,
  }) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.range = range;
  }

  Future<void> finish() async {
    emit(RegistrationLoading());
    try {
      Map data = await profileRepository.sendRegistration(
        name: name!,
        image: path!,
        phone: phone!,
        password: password!,
        latitude: latitude!.toString(),
        longitude: longitude!.toString(),
        distance: range!,
        gender: gender!.id,
        wantToMeet: gender!.id,
        isLgbt: lgbt,
        generation: generations!.map((e) => e.id).toList(),
        earning: earnings!.map((e) => e.id).toList(),
        likes: interests!.map((e) => e.id).toList(),
      );

      if (data.containsKey("apiAccessToken")) {
        var apiToken = data["apiAccessToken"];
        if (apiToken! != null)
          emit(RegistrationWaitCode(apiToken, phone!));
        else {
          emit(RegistrationError(ServerException(
              errorType: LocalizedErrorType.UNEXPECTED,
              message: "There is no token in response")));
        }
      } else {
        emit(RegistrationError(ServerException(
            errorType: LocalizedErrorType.UNEXPECTED,
            message: "There is no token in response")));
      }
    } catch (e) {
      emit(RegistrationError(e));
    }
  }
}
