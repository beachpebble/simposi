import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/gender.dart';
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
      String? facebook,
      String? instagram,
      String? linkedin,
      String? filePath}) async {
    emit(ProfileEditLoading());
    try {
      String? newPath;
      if (filePath != null) {
        newPath = await profileRepository.uploadAvatar(filePath);
      }
      await profileRepository.updateProfile(name: name, filepath: newPath, facebook: facebook, instagram: instagram, linkedin: linkedin);
      emit(ProfileEditSuccess());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }

  Future<void> indentifyAs(Gender gender, bool isLgbt) async {
    emit(ProfileEditLoading());
    try {
      await profileRepository.updateProfileGender(gender: gender, lgbt: isLgbt);
      emit(ProfileEditInitial());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }

  Future<void> iWantToMeet() async {
    emit(ProfileEditLoading());
    try {
      //just a stub
      await Future.delayed(Duration(seconds: 3));
      emit(ProfileEditInitial());
    } catch (e) {
      emit(ProfileEditError(e));
    }
  }
}
