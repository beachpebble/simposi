part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final dynamic error;

  RegistrationError(this.error);

  @override
  List<Object> get props => [error];
}

class RegistrationWaitCode extends RegistrationState {
  final String phone;

  RegistrationWaitCode(this.phone);

  @override
  List<Object> get props => [phone];
}
