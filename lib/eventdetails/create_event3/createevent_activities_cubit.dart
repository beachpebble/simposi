import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/eventdetails/cubit/event_edit_cubit.dart';
import 'package:simposi_app_v4/model/interest.dart';

part 'createevent_activities_state.dart';

class CreateEventActivitiesCubit extends Cubit<CreateEventActivitiesState> {
  CreateEventActivitiesCubit(this.interests, this.eventEditCubit)
      : super(CreateEventActivitiesState(
            interests: interests,
            filtered: interests,
            selected: eventEditCubit.wantToMeetInterests ?? {})) {}

  final EventEditCubit eventEditCubit;
  final Set<Interest> interests;

  Future<void> selectInterest(Interest interest) async {
    Set<Interest> newSelected = {};
    newSelected.addAll(state.selected);
    newSelected.add(interest);
    emit(state.copyWith(selected: newSelected));
    eventEditCubit.setInterests(interests: newSelected);
  }

  Future<void> deselectInterest(Interest interest) async {
    Set<Interest> newSelected = {};
    newSelected.addAll(state.selected);
    newSelected.remove(interest);
    emit(state.copyWith(selected: newSelected));
    eventEditCubit.setInterests(interests: newSelected);
  }

  Future<void> search(String search) async {
    Set<Interest> newFiltered = {}..addAll(state.interests.where((element) =>
        element.title.toLowerCase().contains(search.toLowerCase())));

    //clean selected not in filter
    Set<Interest> newSelected = {}..removeWhere((element) =>
        !element.title.toLowerCase().contains(search.toLowerCase()));

    emit(state.copyWith(filtered: newFiltered));
  }
}
