part of 'signup9_validate_cubit.dart';

abstract class Signup9ValidateState extends Equatable {
  const Signup9ValidateState();

  @override
  List<Object> get props => [];
}

class Signup9ValidateInitial extends Signup9ValidateState {}

class Signup9ValidateLoading extends Signup9ValidateState {}

class Signup9ValidateError extends Signup9ValidateState {
  final dynamic error;

  Signup9ValidateError(this.error);

  @override
  List<Object> get props => [error];
}

class Signup9ValidateSuccess extends Signup9ValidateState {
  final String message;

  Signup9ValidateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class Signup9ResendError extends Signup9ValidateState {
  final dynamic error;

  Signup9ResendError(this.error);

  @override
  List<Object> get props => [error];
}

class Signup9ResendSuccess extends Signup9ValidateState {}