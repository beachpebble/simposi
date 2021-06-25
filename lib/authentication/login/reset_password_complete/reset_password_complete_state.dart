part of 'reset_password_complete_cubit.dart';

abstract class ResetPasswordCompleteState extends Equatable {
  const ResetPasswordCompleteState();

  @override
  List<Object> get props => [];
}

class ResetPasswordCompleteInitial extends ResetPasswordCompleteState {}

class ResetPasswordCompleteProgress extends ResetPasswordCompleteState {}

class ResetPasswordCompleteSuccess extends ResetPasswordCompleteState {
}

class ResetPasswordResendSuccess extends ResetPasswordCompleteState {
}

class ResetPasswordResendError extends ResetPasswordCompleteState {
  final dynamic error;

  ResetPasswordResendError(this.error);

  @override
  List<Object> get props => [error];
}

class ResetPasswordCompleteError extends ResetPasswordCompleteState {
  final dynamic error;

  ResetPasswordCompleteError(this.error);

  @override
  List<Object> get props => [error];
}

class ResetPasswordStateError extends ResetPasswordCompleteState {

}