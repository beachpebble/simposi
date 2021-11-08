import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

import '../../app_constants.dart';

part 'rsvp_event.dart';

part 'rsvp_state.dart';

class RsvpBloc extends Bloc<RsvpEvent, RsvpState> {
  CalendarRepository _calendarRepository;
  ProfileRepository _profileRepository;
  List<EventModel> _loadedEvents = [];
  late StreamSubscription authSubscription;

  RsvpBloc(AuthenticationBloc authBloc, CalendarRepository calendarRepository,
      ProfileRepository profileRepository)
      : _calendarRepository = calendarRepository,
        _profileRepository = profileRepository,
        super(RsvpLoaded([])) {
    authSubscription = authBloc.stream.listen((state) {
      if (state is NotAuthenticated) {
        _loadedEvents.clear();
      } else if (state is Authenticated) {
        add(RefreshRequested(
            DateTime.now()
                .subtract(Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL)),
            DateTime.now()
                .add(Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL))));
      }
    });
    on<RefreshRequested>((event, emit) async {
      if (authBloc.state is Authenticated) {
        emit(RsvpLoading());
        try {
          var rsvps =
              await _calendarRepository.getAllevents(event.from, event.to);
          _loadedEvents = rsvps
              .map((e) => EventModel(
                  rsvp: e,
                  normalizedDate: e.date,
                  isMine: e.event.userId != _profileRepository.profile.userId))
              .toList()
            ..sort((e1, e2) {
              return e1.normalizedDate.compareTo(e2.normalizedDate);
            });

          emit(RsvpLoaded(_loadedEvents));
        } on Exception catch (e) {
          emit(RsvpError(e));
        }
      }
    });

    on<RsvpOpened>((event, emit) async {
      List<EventModel> loadedEvents = []..addAll(_loadedEvents);
      _loadedEvents = _loadedEvents;
      //_loadedEvents.where((element) => element.rsvp.id == event.rsvp.id).first.rsvp.status =
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
