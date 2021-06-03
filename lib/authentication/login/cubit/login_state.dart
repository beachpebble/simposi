part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginProgress extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
