part of 'signup8_validate_cubit.dart';

abstract class Signup8ValidateState extends Equatable {
  const Signup8ValidateState();

  @override
  List<Object> get props => [];
}

class Signup8ValidateInitial extends Signup8ValidateState {}

class Signup8ValidateLoading extends Signup8ValidateState {}

class Signup8ValidateError extends Signup8ValidateState {
  final dynamic error;

  const Signup8ValidateError(this.error);

  @override
  List<Object> get props => [error];
}

class Signup8ValidateSuccess extends Signup8ValidateState {
  final String message;

  const Signup8ValidateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class Signup8ResendError extends Signup8ValidateState {
  final dynamic error;

  const Signup8ResendError(this.error);

  @override
  List<Object> get props => [error];
}

class Signup8ResendSuccess extends Signup8ValidateState {}