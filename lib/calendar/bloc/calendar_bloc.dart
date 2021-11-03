import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
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
  late StreamSubscription todosSubscription;

  CalendarBloc(AuthenticationBloc authBloc, CalendarRepository calendarRepository,
      ProfileRepository profileRepository)
      : _calendarRepository = calendarRepository,
        _profileRepository = profileRepository,
        super(CalendarLoaded(
            SimposiDateUtils.weekStart(DateUtils.dateOnly(DateTime.now())),
            [],
            0,
            LoadBy.INITIAL,
            0)) {
    todosSubscription = authBloc.stream.listen((state) {
      if (state is NotAuthenticated) {
        _loadedEvents.clear();
      } else  if (state is Authenticated) {
        add(Reload(
            DateTime.now().subtract(Duration(days: 90)),
            DateTime.now().add(Duration(days: 90))));
      }
    });

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

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
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


  CalendarRepository _calendarRepository;
  ProfileRepository _profileRepository;
}

enum LoadBy { CALENDAR, LIST, INITIAL }
