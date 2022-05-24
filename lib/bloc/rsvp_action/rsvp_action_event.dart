part of 'rsvp_action_bloc.dart';

abstract class RsvpActionEvent extends Equatable {
  const RsvpActionEvent();
}

class RsvpActionOpened extends RsvpActionEvent {
  final Rsvp rsvp;

  const RsvpActionOpened(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpActionAccepted extends RsvpActionEvent {
  final Rsvp rsvp;

  const RsvpActionAccepted(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpActionDeclined extends RsvpActionEvent {
  final Rsvp rsvp;

  const RsvpActionDeclined(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpActionCanceled extends RsvpActionEvent {
  final Rsvp rsvp;

  const RsvpActionCanceled(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class EventActionCanceled extends RsvpActionEvent {
  final Rsvp rsvp;

  const EventActionCanceled(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}