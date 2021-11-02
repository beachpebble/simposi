import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/date_utils.dart';

import '../event_model.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

EventTransformer<CalendarEvent> debounce<CalendarEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  List<EventModel> _loadedEvents = [];

  CalendarBloc(CalendarRepository calendarRepository,
      ProfileRepository profileRepository)
      : _calendarRepository = calendarRepository,
        _profileRepository = profileRepository,
        super(CalendarLoaded(
            SimposiDateUtils.weekStart(DateUtils.dateOnly(DateTime.now())),
            [],
            0,
            LoadBy.INITIAL,
            0)) {
    on<WeekSelected>((event, emit) {
      _calendarScrolled(event, emit);
    }, transformer: debounce(const Duration(milliseconds: 200)));

    on<ListScrolled>((event, emit) {
      _listScrolled(event, emit);
    }, transformer: debounce(const Duration(milliseconds: 300)));

    on<Reload>((event, emit) async {
      emit(CalendarLoading());
      var rsvps = await _calendarRepository.getAllevents(event.from, event.to);
      _loadedEvents = rsvps
          .map((e) => EventModel(
              rsvp: e,
              normalizedDate: e.date,
              isMine: e.event.userId == _profileRepository.profile.userId))
          .toList()
        ..sort((e1, e2) {
          return e1.normalizedDate.compareTo(e2.normalizedDate);
        });

      emit(CalendarLoaded(weekStart, _loadedEvents, 0, LoadBy.INITIAL, 0));
    });
  }

  _calendarScrolled(WeekSelected event, Emitter<CalendarState> emit) {
    weekStart = event.weekStart;
    updateFromWeek = true;
    int index = _getIndexByFirstDate(event.weekStart);
    emit(CalendarLoaded(weekStart, _loadedEvents, index, LoadBy.CALENDAR, 0));
  }

  _listScrolled(ListScrolled event, Emitter<CalendarState> emit) {
    EventModel eventModel = _loadedEvents[event.index];

    DateTime eventWeekStart =
        SimposiDateUtils.weekStart(eventModel.normalizedDate);
    Duration difference = eventWeekStart.difference(weekStart);
    int difInDays = 0;
    if (difference.inDays > 0) difInDays = difference.inDays + 1;
    if (difference.inDays < 0) difInDays = difference.inDays - 1;
    int difWeeks = difInDays ~/ 7;
    if (updateFromWeek) {
      updateFromWeek = false;
    } else {
      {
        weekStart = eventWeekStart;
        emit(
            CalendarLoaded(weekStart, _loadedEvents, 0, LoadBy.LIST, difWeeks));
      }
    }
  }

  int _getIndexByFirstDate(DateTime date) {
    EventModel? first;
    for (EventModel ev in _loadedEvents) {
      if (ev.normalizedDate.isAfter(date) ||
          DateUtils.isSameDay(ev.normalizedDate, date)) {
        first = ev;
        break;
      }
    }
    int index = 0;
    if (first != null) {
      index = _loadedEvents.indexOf(first);
    } else if (_loadedEvents.isNotEmpty &&
        date.isAfter(_loadedEvents.last.normalizedDate)) {
      index = _loadedEvents.length - 1;
    }
    return index;
  }

  @override
  Stream<CalendarState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 100));

  bool updateFromWeek = false;

  DateTime weekStart = DateUtils.dateOnly(DateTime.now())
      .subtract(Duration(days: DateTime.now().weekday));

  // static List<Rsvp> _loadedEvents = [
  //   Rsvp(
  //       id: 1,
  //       title: "New super event2",
  //       date: normalizeDate(DateTime.now().subtract(Duration(days: 15)))),
  //   Rsvp(
  //       id: 1,
  //       title: "New super event2",
  //       date: normalizeDate(DateTime.now().subtract(Duration(days: 15)))),
  //   Rsvp(
  //       id: 1,
  //       title: "New super event2",
  //       date: normalizeDate(DateTime.now().subtract(Duration(days: 15)))),
  //   Rsvp(
  //       id: 1,
  //       title: "New super event2",
  //       date: normalizeDate(DateTime.now().subtract(Duration(days: 8)))),
  //   Rsvp(
  //       id: 0, title: "New super event", date: normalizeDate(DateTime.now())),
  //   Rsvp(
  //       id: 2,
  //       title: "New super event3",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 1)))),
  //   Rsvp(
  //       id: 3,
  //       title: "New super event4",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 2)))),
  //   Rsvp(
  //       id: 6,
  //       title: "New super event5",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 5)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 8)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 10)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 20)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 20)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 20)))),
  //   Rsvp(
  //       id: 7,
  //       title: "New super event6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 20)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventsdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 40)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventsdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 41)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventsdsdsdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 41)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventdsdssdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 41)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventdsdssdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 50)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventdsdssdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 51)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventdsdssdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 60)))),
  //   Rsvp(
  //       id: 10,
  //       title: "New super eventdsdssdsd6",
  //       date: normalizeDate(DateTime.now().add(Duration(days: 67)))),
  // ].toList()
  //   ..sort((e1, e2) {
  //     return e1.date.compareTo(e2.date);
  //   });
  CalendarRepository _calendarRepository;
  ProfileRepository _profileRepository;
}

enum LoadBy { CALENDAR, LIST, INITIAL }
