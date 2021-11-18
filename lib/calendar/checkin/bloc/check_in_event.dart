part of 'check_in_bloc.dart';

abstract class CheckInEvent extends Equatable {
  const CheckInEvent();
  @override
  List<Object?> get props => [];
}


class CheckInEventSend extends CheckInEvent {
  final Event event;
  //final Position position;

  CheckInEventSend(this.event);

  @override
  List<Object?> get props => [event];
}