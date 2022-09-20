import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      final response = await profileRepository.login(login, password);
      final Map data = response['data'];
      if (data.containsKey('user') && data['user'] != null) {
        final Map<String, dynamic> user = data['user'];
        if (data.containsKey('token') &&
            data['token'] != null &&
            user.containsKey('verified') &&
            user['verified'] == true) {
          await profileRepository.setProfile(user);
          authenticationBloc.add(SaveAuthEvent(data['token']));
          emit(LoginSuccess());
        } else {
          await profileRepository.setProfile(user);
          emit(const LoginUnconfirmed());
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
