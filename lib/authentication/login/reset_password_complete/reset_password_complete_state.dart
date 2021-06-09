part of 'reset_password_complete_cubit.dart';

abstract class ResetPasswordCompleteState extends Equatable {
  const ResetPasswordCompleteState();

  @override
  List<Object> get props => [];
}

class ResetPasswordCompleteInitial extends ResetPasswordCompleteState {}

class ResetPasswordCompleteProgress extends ResetPasswordCompleteState {}

class ResetPasswordCompleteSuccess extends ResetPasswordCompleteState {
  final bool pwdRestore;

  ResetPasswordCompleteSuccess(this.pwdRestore);

  @override
  List<Object> get props => [pwdRestore];
}

class ResetPasswordCompleteError extends ResetPasswordCompleteState {
  final dynamic error;

  ResetPasswordCompleteError(this.error);

  @override
  List<Object> get props => [error];
}

class ResetPasswordStateError extends ResetPasswordCompleteState {

}