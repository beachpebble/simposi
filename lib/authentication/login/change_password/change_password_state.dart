part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  @override
  List<Object> get props => [];

}

class ChangePasswordInitial extends ChangePasswordState {
}

class ChangePasswordLoading extends ChangePasswordState {
}

class ChangePasswordSuccess extends ChangePasswordState {
}

class ChangePasswordError extends ChangePasswordState {
  final dynamic error;

  const ChangePasswordError(this.error);

  @override
  List<Object> get props => [error];
}