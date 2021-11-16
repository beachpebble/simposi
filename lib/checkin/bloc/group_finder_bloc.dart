import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:simposi_app_v4/model/group_finder_user.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';

part 'group_finder_event.dart';

part 'group_finder_state.dart';

class GroupFinderBloc extends Bloc<GroupFinderEvent, GroupFinderState> {
  late StreamSubscription locationSubscription;
  late StreamSubscription listSubscription;
  final CalendarRepository _calendarRepository;
  final int eventId;
  Position? _currentPosition;
  final Distance distance = new Distance();
  double _startAngle = 0.0;
  var rng = new Random();

  GroupFinderBloc(
      {required CalendarRepository calendarRepository, required this.eventId})
      : _calendarRepository = calendarRepository,
        super(GroupFinderLoaded(null, [], 0.0)) {
    locationSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      add(GroupFinderMyLocationChanged(position));
    });

    listSubscription =
        _getPeriodicStream().listen((List<GroupFinderUser> list) {
      add(GroupFinderUserListUpdated(list));
    });

    on<GroupFinderUserSelect>((event, emit) {
      if (state is GroupFinderLoaded) {
        emit(GroupFinderLoaded(
            event.user, (state as GroupFinderLoaded).users, _startAngle));
      }
    });

    on<GroupFinderMyLocationChanged>((event, emit) {
      _currentPosition = event.position;
      if (state is GroupFinderLoaded) {
        List<GroupUserWithRange> result = (state as GroupFinderLoaded)
            .users
            .map((e) => GroupUserWithRange(
                e.user,
                distance.as(
                    LengthUnit.Meter,
                    new LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    new LatLng(e.user.latitude, e.user.longitude))))
            .toList();
        if (state is GroupFinderLoaded) {
          emit(GroupFinderLoaded(
              (state as GroupFinderLoaded).userSelected, result, _startAngle));
        } else {
          emit(GroupFinderLoaded(null, result, _startAngle));
        }
      }
    });
    on<GroupFinderUserListUpdated>((event, emit) {
      if (_startAngle == 0.0) {
        _startAngle = rng.nextDouble() * 7;
      }
      if (_currentPosition != null) {
        List<GroupUserWithRange> result = event.users
            .map((e) => GroupUserWithRange(
                e,
                distance.as(
                    LengthUnit.Meter,
                    new LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    new LatLng(e.latitude, e.longitude))))
            .toList();
        if (state is GroupFinderLoaded) {
          emit(GroupFinderLoaded(
              (state as GroupFinderLoaded).userSelected, result, _startAngle));
        } else {
          emit(GroupFinderLoaded(null, result, _startAngle));
        }
      }
    });
  }

  Stream<List<GroupFinderUser>> _getPeriodicStream() async* {
    yield* Stream.periodic(Duration(seconds: 10), (_) {
      return _calendarRepository.refreshLocator(eventId);
    }).asyncMap(
      (value) async => await value,
    );
  }

  @override
  Future<void> close() {
    print("!!! close");
    locationSubscription.cancel();
    listSubscription.cancel();
    return super.close();
  }
}
