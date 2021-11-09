import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final String TOKEN_KEY = 'token_key';
  String? _token;

  AuthenticationBloc() : super(AuthenticationLoading()) {
    on<ReloadAuthEvent>((event, emit) async {
      emit(AuthenticationLoading());
      SharedPreferences sp = await SharedPreferences.getInstance();
      _token = sp.getString(TOKEN_KEY);
      if (_token?.isNotEmpty ?? false) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    });
    on<LogOut>((event, emit) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove(TOKEN_KEY);
      emit(NotAuthenticated());
    });
    on<Auth401>((event, emit) async {
      if (state is Authenticated) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.remove(TOKEN_KEY);
        emit(NotAuthenticated(loginScreen: true));
      }
    });
    on<LoggedOut>((event, emit) async {
      emit(NotAuthenticated());
    });
    on<SaveAuthEvent>((event, emit) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      _token = event.token;
      await sp.setString(TOKEN_KEY, event.token);
      emit(Authenticated());
    });
  }

  String? get token => _token;
}
