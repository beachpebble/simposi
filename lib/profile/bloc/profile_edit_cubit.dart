import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/profile.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit({required this.profileRepository})
      : super(ProfileEditInitial());

  final ProfileRepository profileRepository;

  get profile => profileRepository.profile;

  Future<void> indentifyAs() async {
    emit(ProfileEditLoading());
    try {
      //just a stub
      await Future.delayed(Duration(seconds: 3));
      emit(ProfileEditInitial());
    } catch (e) {
      emit(ProfileEditError());
    }
  }

  Future<void> iWantToMeet() async {
    emit(ProfileEditLoading());
    try {
      //just a stub
      await Future.delayed(Duration(seconds: 3));
      emit(ProfileEditInitial());
    } catch (e) {
      emit(ProfileEditError());
    }
  }

}
