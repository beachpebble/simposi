import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';
import 'package:simposi_app_v4/utils/location.dart';

part 'check_in_event.dart';

part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CalendarRepository _calendarRepository;

  CheckInBloc({required CalendarRepository calendarRepository})
      : _calendarRepository = calendarRepository,
        super(CheckInInitial()) {
    on<CheckInEventSend>((event, emit) async {
      emit(CheckInLoading());
      Position p;
      try {
        p = await determinePosition();
      } catch (e) {
        emit(CheckInLocationPermission());
        return;
      }

      try {
        await _calendarRepository.checkIn(
            rsvpId: event.rsvp.id, eventId: event.rsvp.event.id);
        await _calendarRepository.groupFinder(
            eventId: event.rsvp.event.id,
            latitude: p.latitude.toString(),
            longitude: p.longitude.toString());
        emit(CheckInSuccess());
      } catch (e) {
        emit(CheckInError(e));
      }
    });
  }
}
