import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/api_service.dart';
import 'package:simposi_app_v4/repository/auth_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationBloc, required this.profileRepository})
      : super(LoginInitial());

  final AuthenticationBloc authenticationBloc;
  final ProfileRepository profileRepository;

  Future<void> login(String login, String password) async {
    emit(LoginProgress());

    try {
      Map data = await profileRepository.login(login, password);

      if (data.containsKey('apiAccessToken') &&
          data['apiAccessToken'] != null && data.containsKey('confirmed') &&
          data['confirmed'] != null ) {
        await profileRepository.setProfile(data);
        if (data['confirmed'] == 1 ) {
          emit(LoginSuccess());
          authenticationBloc.add(SaveAuthEvent(data['apiAccessToken']));
        } else {
          emit(LoginUnconfirmed(data['apiAccessToken']));
        }
      } else {
        emit(LoginError(AuthException(
            message: "Login successful but does not contain token or required fields")));
      }
    }  catch (e) {
      emit(LoginError(e));
    }
  }
}
