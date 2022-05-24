part of 'signup1_create_account_cubit.dart';

abstract class Signup1CreateAccountState extends Equatable {
  const Signup1CreateAccountState();

  @override
  List<Object> get props => [];
}

class Signup1CreateAccountInitial extends Signup1CreateAccountState {}

class Signup1CreateAccountLoading extends Signup1CreateAccountState {}

class Signup1CreateAccountReady extends Signup1CreateAccountState {}

class Signup1CreateAccountError extends Signup1CreateAccountState {
  final dynamic error;

  const Signup1CreateAccountError(this.error);

  @override
  List<Object> get props => [error];
}
