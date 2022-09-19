import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';

part 'signup6_location_state.dart';

class Signup6LocationCubit extends Cubit<Signup6LocationState> {
  Signup6LocationCubit({
    required this.registrationCubit,
    required this.profileBloc,
    bool editMode = false,
  }) : super(editMode
            ? Signup6LocationState.initial(
                double.parse(
                    (profileBloc.state as ProfileLoaded).userProfile.range),
                double.parse(
                    (profileBloc.state as ProfileLoaded).userProfile.latitude),
                double.parse(
                    (profileBloc.state as ProfileLoaded).userProfile.longitude),
                editMode)
            : Signup6LocationState.initial(
                registrationCubit.range,
                registrationCubit.latitude,
                registrationCubit.longitude,
                editMode)) {
    profileEditSubscription = profileBloc.stream.listen((state) {
      if (state is ProfileEditLoading) {
        emit(Signup6LocationStateLoading(state: this.state));
      } else if (state is ProfileEditSuccess) {
        emit(Signup6LocationStateSuccess(state: this.state));
      } else if (state is ProfileEditError) {
        emit(Signup6LocationStateError(state: this.state, error: state.error));
      } else {
        emit(this.state.copyWith());
      }
    });
  }

  final RegistrationCubit registrationCubit;
  final ProfileBloc profileBloc;
  late StreamSubscription profileEditSubscription;

  //TODO move keys to one place
  final places =
      GoogleMapsPlaces(apiKey: "AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI");

  Future<void> searchPlace(String searchStr) async {
    final response = await places.searchByText(searchStr);
    emit(state.copyWith(searchResults: response.results));
  }

  Future<void> selectInitialLocation(LatLng location) async {
    print("selectInitialLocation  $location");
    if (state.selectedLocation == null) {
      emit(state.copyWith(selectedLocation: location, searchResults: []));
      if (!state.editMode) {
        registrationCubit.setLocation(
            latitude: location.latitude, longitude: location.longitude);
      }
    }
  }

  Future<void> selectLocation(LatLng location) async {
    print("selectLocation  $location");
    emit(state.copyWith(selectedLocation: location, searchResults: []));
    if (!state.editMode) {
      registrationCubit.setLocation(
          latitude: location.latitude, longitude: location.longitude);
    }
  }

  Future<void> save() async {
    if (state.editMode) {
      profileBloc.add(ProfileUpdateLocation(state.selectedLocation!.latitude,
          state.selectedLocation!.longitude, state.rangeKm));
    }
  }

  Future<void> noPermission() async {
    emit(
        state.copyWith(selectedLocation: const LatLng(48.4613359, 35.0627361)));
  }

  Future<void> selectRange(double range) async {
    emit(state.copyWith(range: range));
    if (!state.editMode) registrationCubit.setRange(range: range);
  }

  @override
  Future<void> close() {
    profileEditSubscription.cancel();
    return super.close();
  }
}
