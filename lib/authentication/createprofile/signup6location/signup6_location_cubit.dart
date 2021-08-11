import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';

part 'signup6_location_state.dart';

class Signup6LocationCubit extends Cubit<Signup6LocationState> {
  Signup6LocationCubit({required this.registrationCubit}) : super(Signup6LocationState.initial(registrationCubit.range, registrationCubit.latitude, registrationCubit.longitude)) ;

  final RegistrationCubit registrationCubit;

  //TODO move keys to one place
  final places =
  new GoogleMapsPlaces(apiKey: "AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI");

  Future<void> searchPlace(String searchStr) async {
    PlacesSearchResponse response = await places.searchByText(searchStr);
    emit(state.copyWith(searchResults: response.results));
  }

  Future<void> selectInitialLocation(LatLng location) async {
    if (state.selectedLocation == null) {
      emit(state.copyWith(selectedLocation: location, searchResults: []));
      registrationCubit.setLocation(latitude: location.latitude, longitude: location.longitude);
    }
  }

  Future<void> selectLocation(LatLng location) async {
    emit(state.copyWith(selectedLocation: location, searchResults: []));
    registrationCubit.setLocation(latitude: location.latitude, longitude: location.longitude);
  }

  Future<void> noPermission() async {
    emit(state.copyWith(selectedLocation: LatLng(48.4613359, 35.0627361)));
  }

  Future<void> selectRange(double range) async {
    emit(state.copyWith(range: range));
    registrationCubit.setRange(range: range);

  }

}
