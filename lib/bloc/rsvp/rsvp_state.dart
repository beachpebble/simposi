part of 'rsvp_bloc.dart';

abstract class RsvpState extends Equatable {
  const RsvpState();
}

class RsvpLoaded extends RsvpState {

  final List<EventModel> rsvps;

  RsvpLoaded(this.rsvps);

  @override
  List<Object> get props => [rsvps];
}

class RsvpLoading extends RsvpState {

  const RsvpLoading();

  @override
  List<Object> get props => [];
}

class RsvpError extends RsvpState {

  final dynamic error;

  RsvpError(this.error);

  @override
  List<Object> get props => [error];
}