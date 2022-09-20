import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';

part 'rsvp_action_event.dart';

part 'rsvp_action_state.dart';

class RsvpActionBloc extends Bloc<RsvpActionEvent, RsvpActionState> {
  final CalendarRepository _calendarRepository;
  final RsvpBloc _rsvpBloc;

  RsvpActionBloc(
      {required RsvpBloc rsvpBloc,
      required CalendarRepository calendarRepository})
      : _rsvpBloc = rsvpBloc,
        _calendarRepository = calendarRepository,
        super(RsvpActionInitial()) {
    on<RsvpActionOpened>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED) {
        try {
          final updated = await _calendarRepository.openRsvp(event.rsvp.id);
          emit(const RsvpActionSuccess(true));
          _rsvpBloc.add(RsvpOpened(updated));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });

    on<RsvpActionAccepted>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED ||
          event.rsvp.status.title == RsvpStatus.OPENED) {
        emit(RsvpActionLoading());
        try {
          final updated = await _calendarRepository.acceptRsvp(event.rsvp.id);
          emit(const RsvpActionSuccess());
          _rsvpBloc.add(RsvpAccepted(updated));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });

    on<RsvpActionDeclined>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED ||
          event.rsvp.status.title == RsvpStatus.OPENED) {
        emit(RsvpActionLoading());
        try {
          final updated = await _calendarRepository.declineRsvp(event.rsvp.id);
          emit(const RsvpActionSuccess());
          _rsvpBloc.add(RsvpDeclined(updated));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });

    on<RsvpActionCanceled>((event, emit) async {
      emit(RsvpActionLoading());
      try {
        final updated = await _calendarRepository.cancelRsvp(event.rsvp.id);
        emit(const RsvpActionSuccess());
        _rsvpBloc.add(RsvpCanceled(updated));
      } on Exception catch (e) {
        emit(RsvpActionError(e));
      }
    });

    on<EventActionCanceled>((event, emit) async {
      emit(RsvpActionLoading());
      try {
        await _calendarRepository.cancelEvent(event.rsvp.event.id);
        emit(const RsvpActionSuccess());
        _rsvpBloc.add(RsvpCanceled(event.rsvp));
      } on Exception catch (e) {
        emit(RsvpActionError(e));
      }
    });
  }
}
