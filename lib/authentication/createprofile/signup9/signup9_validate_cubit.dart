import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'signup9_validate_state.dart';

class Signup9ValidateCubit extends Cubit<Signup9ValidateState> {
  Signup9ValidateCubit(
      {required ValidateParameters validateParameters,
      required this.authenticationBloc,
      required this.profileRepository})
      : this.token = validateParameters.token,
        this.phone = validateParameters.phone,
        super(Signup9ValidateInitial());

  final String token;
  final String phone;
  final ProfileRepository profileRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> validate(String code) async {
    if (!(state is Signup9ValidateLoading)) {
      emit(Signup9ValidateLoading());
      try {
        String? token = await profileRepository.acceptCode(phone, code);
        if (token!= null) {
          emit(Signup9ValidateSuccess("Validated"));
          authenticationBloc.add(SaveAuthEvent(token));
        } else {
          emit(Signup9ValidateError(ServerException(errorType: LocalizedErrorType.UNEXPECTED)));
        }

      } catch (e) {
        emit(Signup9ValidateError(e));
      }
    }
  }

  Future<void> resend() async {
    if (!(state is Signup9ValidateLoading)) {
      emit(Signup9ValidateLoading());
      try {
        await profileRepository.sendConfirmationCode(phone);
        emit(Signup9ResendSuccess());
      } catch (e) {
        emit(Signup9ValidateError(e));
      }
    }
  }
}

class ValidateParameters {
  final String phone;
  final String token;

  ValidateParameters(this.phone, this.token);
}
