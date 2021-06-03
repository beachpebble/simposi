import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationBloc, required this.authRepository})
      : super(LoginInitial());

  final AuthenticationBloc authenticationBloc;
  final AuthRepository authRepository;

  Future<void> login(String login, String password) async {
    emit(LoginProgress());
    await Future.delayed(Duration(milliseconds: 2000), () {
      // Do something
    });
    //just a stub saving fake token with long exp date
    await authRepository.saveAuth(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MjI3MDkxMDAsImp0aSI6IjQ4NzZmYmJjYjAwODM3NDY1ZThmN2E1YjQxZjQxZDFlIiwiaXNzIjoicHJlcHJvZC5lZy5taWNyb2YxLm5ldCIsIm5iZiI6MTYyMjcwOTEwMCwiZXhwIjoxNjIyNzk1NTAwLCJkYXRhIjp7ImlkIjoiNDEwIiwibG9naW4iOiIrMzgwNjcxMTAwMDkxIn19.VxOwDTaddLbhXuGqrWgdHl09Vp9IM5NP1jXop__Cokk");
    authenticationBloc.add(ReloadAuthEvent());
  }
}
