part of 'rsvp_bloc.dart';

abstract class RsvpEvent extends Equatable {
  const RsvpEvent();
}

class RefreshRequested extends RsvpEvent {
  final DateTime from;
  final DateTime to;

  RefreshRequested(this.from, this.to);

  @override
  List<Object?> get props => [from, to];
}

class RsvpOpened extends RsvpEvent {
  final Rsvp rsvp;

  RsvpOpened(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpAccepted extends RsvpEvent {
  final Rsvp rsvp;

  RsvpAccepted(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpDeclined extends RsvpEvent {
  final Rsvp rsvp;

  RsvpDeclined(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}

class RsvpCanceled extends RsvpEvent {
  final Rsvp rsvp;

  RsvpCanceled(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}