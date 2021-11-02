part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarLoaded extends CalendarState {
  final DateTime weekStart;
  final List<EventModel> events;
  final int scrollPos;
  final int difWeeks;
  final LoadBy loadBy;

  CalendarLoaded(this.weekStart, this.events, this.scrollPos, this.loadBy, this.difWeeks);

  @override
  List<Object> get props => [weekStart, events, scrollPos, loadBy, difWeeks];

  @override
  String toString() {
    return "CalendarLoaded $weekStart, $scrollPos, $loadBy, $difWeeks";
  }
}

class CalendarLoading extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarError extends CalendarState {
  final dynamic error;

  CalendarError(this.error);

  @override
  List<Object> get props => [error];
}
