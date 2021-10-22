import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simposi_app_v4/model/event.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/utils/date_utils.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

EventTransformer<CalendarEvent> debounce<CalendarEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(CalendarRepository calendarRepository)
      : _calendarRepository = calendarRepository,
        super(CalendarLoaded(
          SimposiDateUtils.weekStart(DateUtils.dateOnly(DateTime.now())), _loadedEvents, _getIndexByFirstDate( SimposiDateUtils.weekStart(DateUtils.dateOnly(DateTime.now()))), LoadBy.INITIAL, 0)) {
    on<WeekSelected>((event, emit) {
      weekStart = event.weekStart;

      if (updateFromScroll) {
        updateFromScroll = false;
      } else {
        updateFromWeek = true;
        int index = _getIndexByFirstDate(event.weekStart);
        emit(CalendarLoaded(
            weekStart, _loadedEvents, index, LoadBy.CALENDAR, 0));
      }
    }, transformer: debounce(const Duration(milliseconds: 200)));
    on<ListScrolled>((event, emit) {
      CalEvent calEvent = _loadedEvents[event.index];

      DateTime eventWeekStart = SimposiDateUtils.weekStart(calEvent.date);
      print("!!!======== ${calEvent.date.weekday}");
      Duration difference = eventWeekStart.difference(weekStart);
      int difInDays = 0;
      if (difference.inDays > 0) difInDays = difference.inDays + 1;
      if (difference.inDays < 0) difInDays = difference.inDays - 1;
      int difWeeks = difInDays ~/ 7;
      print(
          "DifDays ${difInDays} DifWeeks $difWeeks eventWeekstart $eventWeekStart  weekstart $weekStart");

      if (updateFromWeek) {
        updateFromWeek = false;
      } else {
        if (!(state is CalendarLoaded && (state as CalendarLoaded).loadBy == LoadBy.INITIAL))
          updateFromScroll = true;
        emit(
            CalendarLoaded(weekStart, _loadedEvents, 0, LoadBy.LIST, difWeeks));
      }
    }, transformer: debounce(const Duration(milliseconds: 600)));
  }

  static int _getIndexByFirstDate(DateTime date) {
    CalEvent? first;
    for (CalEvent ev in _loadedEvents) {
      if (ev.date.isAfter(date) || DateUtils.isSameDay(ev.date, date)) {
        first = ev;
        break;
      }
    }
    int index = 0;
    if (first != null) {
      index = _loadedEvents.indexOf(first);
    } else if (_loadedEvents.isNotEmpty && date.isAfter(_loadedEvents.last.date)) {
      index = _loadedEvents.length - 1;
    }
    return index;
  }

  @override
  Stream<CalendarState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 100));

  bool updateFromWeek = false;
  bool updateFromScroll = false;

  DateTime weekStart = DateUtils.dateOnly(DateTime.now())
      .subtract(Duration(days: DateTime.now().weekday));

  static List<CalEvent> _loadedEvents = [
    CalEvent(
        id: 1,
        title: "New super event2",
        date: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 15)))),
    CalEvent(
        id: 1,
        title: "New super event2",
        date: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 15)))),
    CalEvent(
        id: 1,
        title: "New super event2",
        date: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 15)))),
    CalEvent(
        id: 1,
        title: "New super event2",
        date: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 8)))),
    CalEvent(id: 0, title: "New super event", date: DateUtils.dateOnly(DateTime.now())),
    CalEvent(
        id: 2,
        title: "New super event3",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 1)))),
    CalEvent(
        id: 3,
        title: "New super event4",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 2)))),
    CalEvent(
        id: 6,
        title: "New super event5",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 5)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 8)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 10)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 20)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 20)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 20)))),
    CalEvent(
        id: 7,
        title: "New super event6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 20)))),

    CalEvent(
        id: 10,
        title: "New super eventsdsd6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 40)))),
    CalEvent(
        id: 10,
        title: "New super eventsdsd6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 41)))),
    CalEvent(
        id: 10,
        title: "New super eventsdsdsdsd6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 41)))),
    CalEvent(
        id: 10,
        title: "New super eventdsdssdsd6",
        date: DateUtils.dateOnly(DateTime.now().add(Duration(days: 41)))),
  ].toList()
    ..sort((e1, e2) {
      return e1.date.compareTo(e2.date);
    });
  CalendarRepository _calendarRepository;
}

enum LoadBy { CALENDAR, LIST, INITIAL }
