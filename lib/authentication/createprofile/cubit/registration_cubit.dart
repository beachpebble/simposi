
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit({required this.profileRepository})
      : super(RegistrationInitial());

  final ProfileRepository profileRepository;

  String? path;
  String? name;
  String? phone;
  String? password;
  Gender? gender;
  int? generation;
  Set<Earning>? earnings;
  Set<Interest>? interests;
  bool lgbt = false;
  double? latitude;
  double? longitude;
  double? range;
  List<bool> stage8Agree = [false, false, false, false, false, false];

  void stage2Gender({
    required Gender gender,
  }) {
    this.gender = gender;
  }

  void stage2Lgbt({
    required bool lgbt,
  }) {
    this.lgbt = lgbt;
  }

  void setGenerations({
    required int generation,
  }) async {
    this.generation = generation;
  }

  void setEarnings({
    required Set<Earning> earnings,
  }) async {
    this.earnings = earnings;
  }

  void setInterests({
    required Set<Interest> interests,
  }) async {
    this.interests = interests;
    print("save activities ${interests.length}");
  }

  void setLocation({
    required double latitude,
    required double longitude,
  }) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  void setRange({
    required double range,
  }) {
    this.range = range;
  }

  void covidAgree({
    required int agreeNum,
    required bool agreeVal,
  }) {
    this.stage8Agree[agreeNum] = agreeVal;
  }

  void reset() {
    print("!!! reset");
    path = null;
    name = null;
    phone = null;
    password = null;
    gender = null;
    generation = null;
    earnings = null;
    interests = null;
    lgbt = false;
    latitude = null;
    longitude = null;
    range = null;
    stage8Agree = [false, false, false, false, false, false];
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
        distance: range?.toString() ?? "1",
        gender: gender!.id.toString(),
        isLgbt: lgbt,
        //TODO clean this
        generation: generation!,
        earning: earnings!.map((e) => e.id).toList(),
        likes: interests!.map((e) => e.id).toList(),
      );

      if (data.containsKey("data")) {
        await profileRepository.setProfile(data['data']['user']);
        emit(RegistrationWaitCode( phone!));
        reset();
      } else {
        emit(RegistrationError(ServerException(
            errorType: LocalizedErrorType.UNEXPECTED,
            message: "There is no user in response")));
      }
    } catch (e) {
      emit(RegistrationError(e));
    }
  }
}
