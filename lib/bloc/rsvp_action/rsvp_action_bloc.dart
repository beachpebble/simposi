import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';

import '../../app_constants.dart';

part 'rsvp_action_event.dart';
part 'rsvp_action_state.dart';

class RsvpActionBloc extends Bloc<RsvpActionEvent, RsvpActionState> {
  CalendarRepository _calendarRepository;
  RsvpBloc _rsvpBloc;

  RsvpActionBloc({required RsvpBloc rsvpBloc, required CalendarRepository calendarRepository})
      : _rsvpBloc = rsvpBloc, _calendarRepository = calendarRepository, super(RsvpActionInitial()) {

    on<RsvpActionOpened>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED && false) {
        try {
          await _calendarRepository.openRsvp(event.rsvp.id);
          emit(RsvpActionSuccess());
          _rsvpBloc..add(RsvpOpened(event.rsvp));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });

    on<RsvpActionAccepted>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED) {
        emit(RsvpActionLoading());
        try {
          await _calendarRepository.acceptRsvp(event.rsvp.id);
          emit(RsvpActionSuccess());
          _rsvpBloc..add(RsvpAccepted(event.rsvp));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });


    on<RsvpActionDeclined>((event, emit) async {
      if (event.rsvp.status.title == RsvpStatus.INVITED) {
        emit(RsvpActionLoading());
        try {
          await _calendarRepository.declineRsvp(event.rsvp.id);
          emit(RsvpActionSuccess());
          _rsvpBloc..add(RsvpDeclined(event.rsvp));
        } on Exception catch (e) {
          emit(RsvpActionError(e));
        }
      }
    });
  }
}
