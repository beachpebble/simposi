import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/profile.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit({required this.profileRepository})
      : super(ProfileEditInitial());

  final ProfileRepository profileRepository;

  Profile get profile => profileRepository.profile;

  Future<void> updateMainFields(
      {String? name,
      String? phone,
      String? facebook,
      String? instagram,
      String? linkedin,
      String? filePath}) async {
    emit(ProfileEditLoading());
    try {
      String? newPath;
      if (filePath != null) {
        newPath = await profileRepository.uploadProfilePhoto(filePath);
      }
      String? newPhone  = (profileRepository.profile.userPhone != phone && phone!= null && phone.isNotEmpty) ? phone : null;
      //if we want to change phone first check it it exists
      if (newPhone != null) {
        await profileRepository.userNotExist(phone: newPhone);
      }

      await profileRepository.updateProfile(
          name: name,
          filepath: newPath,
          phone: newPhone,
          facebook: facebook,
          instagram: instagram,
          linkedin: linkedin);
      emit(ProfileEditSuccess());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }

  Future<void> indentifyAs(Gender gender, bool isLgbt) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileGender(gender: gender, lgbt: isLgbt);
      emit(ProfileEditSuccess());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }

  Future<void> generation(int generation) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileGenerations(
          generation: generation);
      emit(ProfileEditSuccess());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }

  Future<void> interests(Set<Interest> interests) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileInterests(
          interests: interests.map((e) => e.id).toList());
      emit(ProfileEditSuccess());
    } catch (e) {
      print("!!! error catched ! $e");
      emit(ProfileEditError(e));
    }
  }

  Future<void> location(
      double latitude, double longitude, double range) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileLocation(
          latitude: latitude, longitude: longitude, range: range);
      emit(ProfileEditSuccess());
    } catch (e) {
      print("!!! error catched ! $e");
      emit(ProfileEditError(e));
    }
  }

  Future<void> income(Set<Earning> earnings) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileIncome(
          earnings: earnings.map((e) => e.id).toList());
      emit(ProfileEditSuccess());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }
}
