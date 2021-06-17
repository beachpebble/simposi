part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginProgress extends LoginState {}

class LoginUnconfirmed extends LoginState {
  final String token;

  LoginUnconfirmed(this.token);

  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final dynamic error;

  LoginError(this.error);

  @override
  List<Object> get props => [error];
}
