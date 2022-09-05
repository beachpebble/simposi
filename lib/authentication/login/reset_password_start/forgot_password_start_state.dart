part of 'forgot_password_start_cubit.dart';

abstract class ForgotPasswordStartState extends Equatable {
  const ForgotPasswordStartState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStartInitial extends ForgotPasswordStartState {}

class ForgotPasswordStartLoading extends ForgotPasswordStartState {}

class ForgotPasswordStartSuccess extends ForgotPasswordStartState {}

class ForgotPasswordStartError extends ForgotPasswordStartState {
  final dynamic error;

  const ForgotPasswordStartError(this.error);

  @override
  List<Object> get props => [error];
}
