import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'signup1_create_account_state.dart';

class Signup1CreateAccountCubit extends Cubit<Signup1CreateAccountState> {


  Signup1CreateAccountCubit({required this.registrationCubit, required this.profileRepository}) : super(Signup1CreateAccountInitial());

  final RegistrationCubit registrationCubit;
  final ProfileRepository profileRepository;

  Future<void> firstStage({
    required String file,
    required String name,
    required String phone,
    required String password,
  }) async {
    if (state is Signup1CreateAccountInitial || state is Signup1CreateAccountError || state is Signup1CreateAccountReady) {
      emit(Signup1CreateAccountLoading());
      try {
        bool phoneUsed = await profileRepository.userNotExist(phone: phone);
        if (phoneUsed) {
          emit(Signup1CreateAccountError("Phone is used"));
        } else {
          String? path = await profileRepository.uploadProfilePhoto(file);
          registrationCubit.path = path;
          registrationCubit.name = name;
          registrationCubit.phone = phone;
          registrationCubit.password = password;
          emit(Signup1CreateAccountReady());
        }


      } catch (e) {
        emit(Signup1CreateAccountError(e));
      }
    }
  }

}
