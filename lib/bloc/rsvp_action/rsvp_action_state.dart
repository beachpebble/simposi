part of 'rsvp_action_bloc.dart';

abstract class RsvpActionState extends Equatable {
  const RsvpActionState();

  @override
  List<Object> get props => [];
}

class RsvpActionInitial extends RsvpActionState {}

class RsvpActionLoading extends RsvpActionState {}

class RsvpActionSuccess extends RsvpActionState {}

class RsvpActionError extends RsvpActionState {
  final dynamic error;

  RsvpActionError(this.error);

  @override
  List<Object> get props => [error];
}
