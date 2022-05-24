part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class WeekSelected extends CalendarEvent {
  final DateTime weekStart;

  const WeekSelected(this.weekStart);

  @override
  List<Object?> get props => [weekStart];
}

class ListScrolled extends CalendarEvent {
  final int index;

  const ListScrolled(this.index);

  @override
  List<Object?> get props => [index];
}

class EventsUpdated extends CalendarEvent {
  final List<EventModel> events;

  const EventsUpdated(this.events);

  @override
  List<Object?> get props => [events];
}

class EventsLoading extends CalendarEvent {
  const EventsLoading();
}

class EventsError extends CalendarEvent {
  final dynamic error;

  const EventsError(this.error);

  @override
  List<Object?> get props => [error];
}
