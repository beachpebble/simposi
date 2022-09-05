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

  const LoginUnconfirmed();

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final dynamic error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
