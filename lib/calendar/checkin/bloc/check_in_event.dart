part of 'check_in_bloc.dart';

abstract class CheckInEvent extends Equatable {
  const CheckInEvent();
  @override
  List<Object?> get props => [];
}


class CheckInEventSend extends CheckInEvent {
  final Rsvp rsvp;

  CheckInEventSend(this.rsvp);

  @override
  List<Object?> get props => [rsvp];
}