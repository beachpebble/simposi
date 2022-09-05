part of 'rsvp_action_bloc.dart';

abstract class RsvpActionState extends Equatable {
  const RsvpActionState();

  @override
  List<Object> get props => [];
}

class RsvpActionInitial extends RsvpActionState {}

class RsvpActionLoading extends RsvpActionState {}

class RsvpActionSuccess extends RsvpActionState {
  final bool dontCloseAfterAction;

  const RsvpActionSuccess([this.dontCloseAfterAction = false]);
}

class RsvpActionError extends RsvpActionState {
  final dynamic error;

  const RsvpActionError(this.error);

  @override
  List<Object> get props => [error];
}
