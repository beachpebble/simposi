part of 'rsvp_bloc.dart';

abstract class RsvpState extends Equatable {
  const RsvpState();
}

class RsvpLoaded extends RsvpState {

  final List<EventModel> rsvps;
  final int invited;
  final int accepted;

  RsvpLoaded(this.rsvps) :
    invited = (rsvps.where((element) => element.rsvp.status.id == RsvpStatus.INVITED_ID)).length,
    accepted = (rsvps.where((element) => element.rsvp.status.id == RsvpStatus.ACCEPTED_ID)).length;




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

  const RsvpError(this.error);

  @override
  List<Object> get props => [error];
}