import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/auth_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.profileRepository, required this.authRepository})
      : super(ChangePasswordInitial());

  final ProfileRepository profileRepository;
  final AuthRepository authRepository;

  Future<void> changePassword(String password) async {
    emit(ChangePasswordLoading());
    try {
      String? token = authRepository.jwt;
      if (token != null) {
        await profileRepository.changePassword(password, token);
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordError(AuthException()));
      }
    } catch (e) {
      emit(ChangePasswordError(e));
    }
  }
}
