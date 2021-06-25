import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'signup1_create_account_state.dart';

class Signup1CreateAccountCubit extends Cubit<Signup1CreateAccountState> {


  Signup1CreateAccountCubit({required this.registrationCubit, required this.profileRepository}) : super(Signup1CreateAccountLoadingData());

  final RegistrationCubit registrationCubit;
  final ProfileRepository profileRepository;

  Future<void> preload() async {
    if (state is Signup1CreateAccountLoadingData || state is Signup1CreateAccountLoadingDataError) {
      emit(Signup1CreateAccountLoadingData());
      try {
        MasterData mData = await profileRepository.getMasterData();
        registrationCubit.masterData = mData;
        emit(Signup1CreateAccountInitial());
      } catch (e) {
        emit(Signup1CreateAccountLoadingDataError(e));
      }
    }
  }

  Future<void> firstStage({
    required String file,
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (state is Signup1CreateAccountInitial || state is Signup1CreateAccountError) {
      emit(Signup1CreateAccountLoading());
      try {
        await profileRepository.userNotExist(phone: phone);
        String? path = await profileRepository.uploadAvatar(file);
        if (path != null) {
          registrationCubit.path = path;
          registrationCubit.name = name;
          registrationCubit.phone = phone;
          registrationCubit.email = email;
          registrationCubit.password = password;
          emit(Signup1CreateAccountReady());
        } else {
          emit(Signup1CreateAccountError("File is not loaded"));
        }
      } catch (e) {
        emit(Signup1CreateAccountError(e));
      }
    }

  }

}
