part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
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

class Reload extends CalendarEvent {
  final DateTime from, to;

  Reload(this.from, this.to);

  @override
  List<Object?> get props => [from, to];
}
