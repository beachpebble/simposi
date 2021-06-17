import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'signup9_validate_state.dart';

class Signup9ValidateCubit extends Cubit<Signup9ValidateState> {
  Signup9ValidateCubit(
      {required this.token,
      required this.authenticationBloc,
      required this.profileRepository})
      : super(Signup9ValidateInitial());

  final String token;
  final ProfileRepository profileRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> validate(String code) async {
    emit(Signup9ValidateLoading());
    try {
      String message = await profileRepository.validateCode(code, token);
      emit(Signup9ValidateSuccess(message));
      authenticationBloc.add(SaveAuthEvent(token));
    } catch (e) {
      emit(Signup9ValidateError(e));
    }
  }
}
