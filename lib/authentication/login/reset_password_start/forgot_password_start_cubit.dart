import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'forgot_password_start_state.dart';

class ForgotPasswordStartCubit extends Cubit<ForgotPasswordStartState> {
  ForgotPasswordStartCubit({required this.profileRepository})
      : super(ForgotPasswordStartInitial());

  final ProfileRepository profileRepository;

  Future<void> sendForgotPasswordrequest({required String phone}) async {
    emit(ForgotPasswordStartLoading());
    try {
      await profileRepository.forgotPasswordRequest(phone);
      emit(ForgotPasswordStartSuccess());
    }  catch (e) {
      emit(ForgotPasswordStartError(e));
    }
  }
}
