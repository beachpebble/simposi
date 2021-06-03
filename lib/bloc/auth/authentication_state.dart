part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class NotAuthenticated extends AuthenticationState {}
