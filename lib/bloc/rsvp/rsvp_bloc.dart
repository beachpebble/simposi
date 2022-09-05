import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/bloc/fcm/fcm_bloc.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

import '../../app_constants.dart';

part 'rsvp_event.dart';

part 'rsvp_state.dart';

class RsvpBloc extends Bloc<RsvpEvent, RsvpState> {
  final CalendarRepository _calendarRepository;
  final ProfileRepository _profileRepository;
  List<EventModel> _loadedEvents = [];
  late StreamSubscription authSubscription;
  late StreamSubscription fcmSubscription;

  RsvpBloc(AuthenticationBloc authBloc, FcmBloc fcmBloc, CalendarRepository calendarRepository,
      ProfileRepository profileRepository)
      : _calendarRepository = calendarRepository,
        _profileRepository = profileRepository,
        super(RsvpLoaded(const [])) {
    authSubscription = authBloc.stream.listen((state) {
      if (state is NotAuthenticated) {
        _loadedEvents.clear();
      } else if (state is Authenticated) {
        add(RefreshRequested(
            DateTime.now()
                .subtract(const Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL)),
            DateTime.now()
                .add(const Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL))));
      }
    });

    fcmSubscription = fcmBloc.stream.listen((state) {
      if (state is NewRsvpReceived) {
        add(RefreshRequested(
        DateTime.now().subtract(
  const Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL)),
  DateTime.now().add(const Duration(
  days: AppConstants.CALENDAR_DAYS_INTERVAL))));
      }
    });
    on<RefreshRequested>((event, emit) async {
      if (authBloc.state is Authenticated) {
        emit(const RsvpLoading());
        try {
          _loadedEvents = await _getRsvps(event.from, event.to);
          emit(RsvpLoaded(_loadedEvents));
        } on Exception catch (e) {
          emit(RsvpError(e));
        }
      }
    });

    on<RsvpOpened>((event, emit) async {
      final loadedEvents = <EventModel>[..._loadedEvents];
      loadedEvents.removeWhere((element) => element.rsvp.id == event.rsvp.id);
      final tmp  = EventModel(
          rsvp: event.rsvp,
          normalizedDate: event.rsvp.date,
          myId: _profileRepository.profile.userId);
      loadedEvents.add(tmp);
      loadedEvents.sort(dateComparator);
      _loadedEvents = loadedEvents;
      emit(RsvpLoaded(_loadedEvents));
    });
    on<RsvpAccepted>((event, emit) async {
      final loadedEvents = <EventModel>[..._loadedEvents];
      final tmp  = EventModel(
          rsvp: event.rsvp,
          normalizedDate: event.rsvp.date,
          myId: _profileRepository.profile.userId);
      loadedEvents.removeWhere((element) => element.rsvp.id == event.rsvp.id);
      loadedEvents.add(tmp);
      loadedEvents.sort(dateComparator);
      _loadedEvents = loadedEvents;
      emit(RsvpLoaded(_loadedEvents));
    });
    on<RsvpDeclined>((event, emit) async {
      final loadedEvents = <EventModel>[..._loadedEvents];
      loadedEvents.removeWhere((element) => element.rsvp.id == event.rsvp.id);
      _loadedEvents = loadedEvents;
      emit(RsvpLoaded(_loadedEvents));
    });
    on<RsvpCanceled>((event, emit) async {
      final loadedEvents = <EventModel>[..._loadedEvents];
      loadedEvents.removeWhere((element) => element.rsvp.id == event.rsvp.id);
      _loadedEvents = loadedEvents;
      emit(RsvpLoaded(_loadedEvents));
    });
  }

  Future<List<EventModel>> _getRsvps(DateTime from, DateTime to) async {
    final rsvps =
        await _calendarRepository.getAllevents(from, to);
    return rsvps.where((element) => element.status.id != RsvpStatus.CANCELED_ID && element.status.id != RsvpStatus.DECLINED_ID)
        .map((e) => EventModel(
        rsvp: e,
        normalizedDate: e.date,
        myId: _profileRepository.profile.userId))
        .toList()
      ..sort(dateComparator);
  }

  int Function(EventModel a, EventModel b) dateComparator = (EventModel a, EventModel b) {
    final ams = a.rsvp.event.datetime.millisecondsSinceEpoch;
    final bms = b.rsvp.event.datetime.millisecondsSinceEpoch;
    return ams.compareTo(bms);
  };

  @override
  Future<void> close() {
    authSubscription.cancel();
    fcmSubscription.cancel();
    return super.close();
  }
}
