part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class WeekSelected extends CalendarEvent {
  final DateTime weekStart;

  WeekSelected(this.weekStart);

  @override
  List<Object?> get props => [weekStart];
}

class ListScrolled extends CalendarEvent {
  final int index;

  ListScrolled(this.index);

  @override
  List<Object?> get props => [index];
}

class EventsUpdated extends CalendarEvent {
  final List<EventModel> events;

  EventsUpdated(this.events);

  @override
  List<Object?> get props => [events];
}

class EventsLoading extends CalendarEvent {
  const EventsLoading();
}

class EventsError extends CalendarEvent {
  final dynamic error;

  EventsError(this.error);

  @override
  List<Object?> get props => [error];
}
