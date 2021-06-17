part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class ReloadAuthEvent extends AuthenticationEvent {}

class SaveAuthEvent extends AuthenticationEvent {
  final String token;

  SaveAuthEvent(this.token);
}

class LogOut extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
