import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static const String kTokenKey = 'token_key';
  String? _token;

  AuthenticationBloc() : super(AuthenticationLoading()) {
    on<ReloadAuthEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final sp = await SharedPreferences.getInstance();
      _token = sp.getString(kTokenKey);
      if (_token?.isNotEmpty ?? false) {
        emit(Authenticated());
      } else {
        emit(const NotAuthenticated());
      }
    });
    on<LogOut>((event, emit) async {
      final sp = await SharedPreferences.getInstance();
      sp.remove(kTokenKey);
      emit(const NotAuthenticated());
    });
    on<Auth401>((event, emit) async {
      if (state is Authenticated) {
        final sp = await SharedPreferences.getInstance();
        await sp.remove(kTokenKey);
        emit(const NotAuthenticated(loginScreen: true));
      }
    });
    on<LoggedOut>((event, emit) async {
      emit(const NotAuthenticated());
    });
    on<SaveAuthEvent>((event, emit) async {
      final sp = await SharedPreferences.getInstance();
      _token = event.token;
      await sp.setString(kTokenKey, event.token);
      emit(Authenticated());
    });
  }

  String? get token => _token;
}
