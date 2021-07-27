import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'reset_password_complete_state.dart';

class ResetPasswordCompleteCubit extends Cubit<ResetPasswordCompleteState> {
  ResetPasswordCompleteCubit(
      {required this.profileRepository, required this.phone})
      : super(ResetPasswordCompleteInitial());

  final ProfileRepository profileRepository;
  final String phone;

  String? _token;

  Future<void> sendForgotPasswordComplete(
      {required String password, required String code}) async {
    emit(ResetPasswordCompleteProgress());

    try {
      _token = await profileRepository.acceptCode(phone, code);
      if (_token != null) {
        await profileRepository.changePassword(password, _token!);
        emit(ResetPasswordCompleteSuccess());
      } else {
        emit(ResetPasswordCompleteError(ServerException(
            errorType: LocalizedErrorType.SERVER_ERROR,
            message: "Token is not received")));
      }
    } catch (e) {
      emit(ResetPasswordCompleteError(e));
    }
  }

  Future<void> resend() async {
    emit(ResetPasswordCompleteProgress());
    try {
      await profileRepository.sendConfirmationCode(phone);
      emit(ResetPasswordResendSuccess());
    } catch (e) {
      emit(ResetPasswordResendError(e));
    }
  }
}
