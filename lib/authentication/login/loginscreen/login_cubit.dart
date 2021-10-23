import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required this.authenticationBloc, required this.profileRepository})
      : super(LoginInitial());

  final AuthenticationBloc authenticationBloc;
  final ProfileRepository profileRepository;

  Future<void> login(String login, String password) async {
    emit(LoginProgress());

    try {
      var response = await profileRepository.login(login, password);
      Map data = response['data'];
      if (data.containsKey('user') && data['user'] != null) {
        Map user = data['user'];
        if (data.containsKey('token') &&
            data['token'] != null &&
            user.containsKey('verified') &&
            user['verified'] == true) {
          await profileRepository.setProfile(data);
          emit(LoginSuccess());
          authenticationBloc.add(SaveAuthEvent(data['token']));
        } else {
          emit(LoginUnconfirmed());
        }
      } else {
        emit(LoginError(AuthException(
            message:
                "Login successful but does not contain token or required fields")));
      }
    } catch (e) {
      emit(LoginError(e));
    }
  }
}
