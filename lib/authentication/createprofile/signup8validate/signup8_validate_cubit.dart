import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'signup8_validate_state.dart';

class Signup8ValidateCubit extends Cubit<Signup8ValidateState> {
  Signup8ValidateCubit(
      {required ValidateParameters validateParameters,
      required this.authenticationBloc,
      required this.profileRepository})
      : this.phone = validateParameters.phone,
        super(Signup8ValidateInitial());

  final String phone;
  final ProfileRepository profileRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> validate(String code) async {
    if (!(state is Signup8ValidateLoading)) {
      emit(Signup8ValidateLoading());
      try {
        String? token = await profileRepository.acceptCode(phone, code);
        if (token != null) {
          emit(Signup8ValidateSuccess("Validated"));
          await Future.delayed(Duration(seconds: 1));
          authenticationBloc.add(SaveAuthEvent(token));
        } else {
          emit(Signup8ValidateError(
              ServerException(errorType: LocalizedErrorType.UNEXPECTED)));
        }
      } catch (e) {
        emit(Signup8ValidateError(e));
      }
    }
  }

  Future<void> resend() async {
    if (!(state is Signup8ValidateLoading)) {
      emit(Signup8ValidateLoading());
      try {
        await profileRepository.requestConfirmationCode(phone);
        emit(Signup8ResendSuccess());
      } catch (e) {
        emit(Signup8ValidateError(e));
      }
    }
  }
}

class ValidateParameters {
  final String phone;

  ValidateParameters(this.phone);
}
