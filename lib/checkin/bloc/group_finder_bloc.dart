import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/group_finder_user.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/location.dart';

import '../../app_constants.dart';

part 'group_finder_event.dart';

part 'group_finder_state.dart';

class GroupFinderBloc extends Bloc<GroupFinderEvent, GroupFinderState> {
  StreamSubscription? locationSubscription;
  StreamSubscription? locationStateSubscription;
  StreamSubscription? listSubscription;
  final CalendarRepository _calendarRepository;
  final ProfileRepository _profileRepository;
  final ProfileBloc _profileBloc;
  final RsvpBloc _rsvpBloc;
  final int eventId;
  Position? _currentPosition;
  final Distance distance = new Distance();
  double _startAngle = 0.0;
  var rng = new Random();

  GroupFinderBloc({
    required RsvpBloc rsvpBloc,
    required CalendarRepository calendarRepository,
    required ProfileRepository profileRepository,
    required this.eventId,
    required ProfileBloc profileBloc,
  })  : _calendarRepository = calendarRepository,
        _profileRepository = profileRepository,
        _profileBloc = profileBloc,
        _rsvpBloc = rsvpBloc,
        super(GroupFinderLoaded(null, [], 0.0)) {
    on<GroupFinderUserSelect>((event, emit) {
      _userSelect(event, emit);
    });

    on<GroupFinderMyLocationChanged>((event, emit) {
      _locationChanged(event, emit);
    });
    on<GroupFinderUserListUpdated>((event, emit) {
      _listUpdated(event, emit);
    });
    on<GroupFinderLocationDisabled>((event, emit) {
      emit(GroupFinderLocationError());
    });
    on<GroupFinderErrorEvent>((event, emit) {
      emit(GroupFinderError(event.error));
    });

    on<GroupFinderPermissionLost>((event, emit) {
      emit(GroupFinderNoPermissions());
    });
    on<GroupFinderPermissionRefresh>((event, emit) async {
      await _permissionRefresh(event, emit);
    });
  }

  _userSelect(GroupFinderUserSelect event, Emitter<GroupFinderState> emit) {
    if (state is GroupFinderLoaded) {
      emit(GroupFinderLoaded(
          event.user, (state as GroupFinderLoaded).users, _startAngle));
    }
  }

  _locationChanged(
      GroupFinderMyLocationChanged event, Emitter<GroupFinderState> emit) {
    _currentPosition = event.position;
    if (state is GroupFinderLoaded) {
      List<GroupUserWithRange> result = (state as GroupFinderLoaded)
          .users
          .map((e) => GroupUserWithRange(
              e.user,
              distance.as(
                  LengthUnit.Meter,
                  new LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  new LatLng(double.parse(e.user.latitude),
                      double.parse(e.user.longitude)))))
          .toList();
      if (state is GroupFinderLoaded) {
        emit(GroupFinderLoaded(
            (state as GroupFinderLoaded).userSelected, result, _startAngle));
      } else {
        emit(GroupFinderLoaded(null, result, _startAngle));
      }
    }
  }

  _listUpdated(
      GroupFinderUserListUpdated event, Emitter<GroupFinderState> emit) {
    if (_startAngle == 0.0) {
      _startAngle = rng.nextDouble() * 7;
    }
    if (_currentPosition != null) {
      List<GroupUserWithRange> result = event.users
          .where((element) => element.id != _profileRepository.profile.userId)
          .map((e) => GroupUserWithRange(
              e,
              distance.as(
                  LengthUnit.Meter,
                  new LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  new LatLng(
                      double.parse(e.latitude), double.parse(e.longitude)))))
          .toList();
      if (state is GroupFinderLoaded) {
        emit(GroupFinderLoaded(
            (state as GroupFinderLoaded).userSelected, result, _startAngle));
      } else {
        emit(GroupFinderLoaded(null, result, _startAngle));
      }
    }
  }

  _permissionRefresh(GroupFinderPermissionRefresh event,
      Emitter<GroupFinderState> emit) async {
    try {
      await checkPermissions();
      locationSubscription?.cancel();
      locationSubscription =
          Geolocator.getPositionStream().listen((Position position) {
        add(GroupFinderMyLocationChanged(position));
      });

      locationStateSubscription?.cancel();
      locationStateSubscription =
          Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
        if (status == ServiceStatus.enabled &&
            state is GroupFinderLocationDisabled) {
          add(GroupFinderLocationEnabled());
        } else if (status == ServiceStatus.disabled) {
          add(GroupFinderLocationDisabled());
        }
      }, onError: (v) {
        _checkEventNotChecked(v);
        add(GroupFinderErrorEvent(v));
      });

      listSubscription?.cancel();
      listSubscription =
          _getPeriodicStream().listen((List<GroupFinderUser>? list) {
        if (list != null) add(GroupFinderUserListUpdated(list));
      }, onError: (v) {
        _checkEventNotChecked(v);
        add(GroupFinderErrorEvent(v));
      });

      if (_currentPosition != null)
        _calendarRepository
            .groupFinder(
                eventId: eventId,
                latitude: _currentPosition!.latitude.toString(),
                longitude: _currentPosition!.longitude.toString())
            .then((value) => add(GroupFinderUserListUpdated(value)));
    } catch (e) {
      add(GroupFinderPermissionLost());
    }
  }

  void _checkEventNotChecked(Exception v) {
    if (v is DioError && v.type == DioErrorType.response) {
      if (v.response?.statusCode == 422 &&
          getDioResponseError(v) == 'User not checked-in on this Event') {
        _profileBloc.add(ProfileReload());
        _rsvpBloc.add(RefreshRequested(
            DateTime.now().subtract(
                Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL)),
            DateTime.now().add(Duration(
                days: AppConstants.CALENDAR_DAYS_INTERVAL))));
      }
    }
  }

  Stream<List<GroupFinderUser>?> _getPeriodicStream() async* {
    yield* Stream.periodic(Duration(seconds: 10), (_) {
      if (_currentPosition != null)
        return _calendarRepository.groupFinder(
            eventId: eventId,
            latitude: _currentPosition!.latitude.toString(),
            longitude: _currentPosition!.longitude.toString());
    }).asyncMap(
      (value) async => value,
    );
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    listSubscription?.cancel();
    locationStateSubscription?.cancel();
    return super.close();
  }
}
