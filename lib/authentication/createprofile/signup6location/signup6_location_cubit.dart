import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/profile/bloc/profile_edit_cubit.dart';

part 'signup6_location_state.dart';

class Signup6LocationCubit extends Cubit<Signup6LocationState> {
  Signup6LocationCubit(
      {required this.registrationCubit,
      required this.profileEditCubit,
      bool editMode = false})
      : super(editMode
            ? Signup6LocationState.initial(
                profileEditCubit.profile.range,
                profileEditCubit.profile.latitude,
                profileEditCubit.profile.longitude,
                editMode)
            : Signup6LocationState.initial(
                registrationCubit.range,
                registrationCubit.latitude,
                registrationCubit.longitude,
                editMode)) {
    profileEditSubscription = profileEditCubit.stream.listen((state) {
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
  final ProfileEditCubit profileEditCubit;
  late StreamSubscription profileEditSubscription;

  //TODO move keys to one place
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI");

  Future<void> searchPlace(String searchStr) async {
    PlacesSearchResponse response = await places.searchByText(searchStr);
    emit(state.copyWith(searchResults: response.results));
  }

  Future<void> selectInitialLocation(LatLng location) async {
    print("selectInitialLocation  $location");
    if (state.selectedLocation == null) {
      emit(state.copyWith(selectedLocation: location, searchResults: []));
      if (!state.editMode)
        registrationCubit.setLocation(
            latitude: location.latitude, longitude: location.longitude);
    }
  }

  Future<void> selectLocation(LatLng location) async {
    print("selectLocation  $location");
    emit(state.copyWith(selectedLocation: location, searchResults: []));
    if (!state.editMode)
      registrationCubit.setLocation(
          latitude: location.latitude, longitude: location.longitude);
  }

  Future<void> save() async {
    if (state.editMode) {
      profileEditCubit.location(state.selectedLocation!.latitude, state.selectedLocation!.longitude, state.rangeKm);
    }
  }

  Future<void> noPermission() async {
    emit(state.copyWith(selectedLocation: LatLng(48.4613359, 35.0627361)));
  }

  Future<void> selectRange(double range) async {
    emit(state.copyWith(range: range));
    if (!state.editMode) registrationCubit.setRange(range: range);
  }
}
