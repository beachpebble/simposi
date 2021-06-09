import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'reset_password_complete_state.dart';

class ResetPasswordCompleteCubit extends Cubit<ResetPasswordCompleteState> {
  ResetPasswordCompleteCubit({required this.profileRepository, required this.authenticationBloc})
      : super(ResetPasswordCompleteInitial());

  final ProfileRepository profileRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> sendForgotPasswordComplete({required String password, String? hash}) async {
    emit(ResetPasswordCompleteProgress());

    if (hash == null) {
      if (authenticationBloc.state is Authenticated) {
        try {
          await profileRepository.changePassword(password);
          emit(ResetPasswordCompleteSuccess(false));
        } catch (e) {
          emit(ResetPasswordCompleteError(e));
        }
      } else {
        emit(ResetPasswordStateError());
      }
    } else {
      try {
        await profileRepository.forgotPasswordComplete(password, hash);
        emit(ResetPasswordCompleteSuccess(true));
      } catch (e) {
        emit(ResetPasswordCompleteError(e));
      }
    }
  }
}
