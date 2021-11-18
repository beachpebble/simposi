part of 'check_in_bloc.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();

  @override
  List<Object> get props => [];
}

class CheckInInitial extends CheckInState {
}

class CheckInLoading extends CheckInState {
}

class CheckInSuccess extends CheckInState {
}

class CheckInLocationPermission extends CheckInState {
}

class CheckInError extends CheckInState {
  final dynamic error;

  CheckInError(this.error);

  @override
  List<Object> get props => [error];
}