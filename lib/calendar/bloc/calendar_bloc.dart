import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/utils/date_utils.dart';

import '../event_model.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

EventTransformer<CalendarEvent> debounce<CalendarEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  List<EventModel> _loadedEvents = [];
  late StreamSubscription _subscription;

  CalendarBloc(RsvpBloc rsvpBloc)
      : super(CalendarLoaded(
            SimposiDateUtils.weekStart(DateUtils.dateOnly(DateTime.now())),
            rsvpBloc.state is RsvpLoaded
                ? (rsvpBloc.state as RsvpLoaded).rsvps
                : [],
            0,
            LoadBy.INITIAL,
            0)) {
    _subscription = rsvpBloc.stream.listen((state) {
      if (state is RsvpLoaded) {
        _loadedEvents = state.rsvps;
        add(EventsUpdated(_loadedEvents));
      } else if (state is RsvpLoading) {
        add(EventsLoading());
      } else if (state is RsvpError) {
        add(EventsError(state.error));
      }
    });

    on<WeekSelected>((event, emit) {
      _calendarScrolled(event, emit);
    }, transformer: debounce(const Duration(milliseconds: 200)));

    on<ListScrolled>((event, emit) {
      _listScrolled(event, emit);
    }, transformer: debounce(const Duration(milliseconds: 300)));

    on<EventsUpdated>((event, emit) async {
      emit(CalendarLoaded(weekStart, _loadedEvents, 0, LoadBy.INITIAL, 0));
    });

    on<EventsLoading>((event, emit) async {
      emit(CalendarLoading());
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
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
}

enum LoadBy { CALENDAR, LIST, INITIAL }
