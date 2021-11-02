import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/eventdetails/cubit/event_edit_cubit.dart';
import 'package:geocoding/geocoding.dart';

part 'createevent2_location_state.dart';

class CreateEvent2LocationCubit extends Cubit<CreateEvent2LocationState> {
  CreateEvent2LocationCubit({required this.editEventCubit})
      : super(CreateEvent2LocationState.initial(
            editEventCubit.latitude, editEventCubit.longitude));

  final EventEditCubit editEventCubit;

  //TODO move keys to one place
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI");

  Future<void> searchPlace(String searchStr) async {
    PlacesSearchResponse response = await places.searchByText(searchStr);
    emit(state.copyWith(searchResults: response.results));
  }



  Future<void> refreshInitial() async {
    if (state.selectedLocation == null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(state.selectedLocation!.latitude, state.selectedLocation!.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.subAdministrativeArea}, ${place.street}";
        emit(state.copyWith(address: address));
        editEventCubit.stage2SetLocation(
            latitude: state.selectedLocation!.latitude, longitude: state.selectedLocation!.longitude, city: place.subAdministrativeArea??"", address: place.street??"");
      }
    }
  }

  Future<void> selectInitialLocation(LatLng location) async {
    print("selectInitialLocation  $location");
    if (state.selectedLocation == null) {
      selectLocation(location);
    }
  }

//TODO make smarter
  Future<void> selectLocation(LatLng location) async {
    emit(state.copyWith(selectedLocation: location, searchResults: [], ));
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      String address = "${place.subAdministrativeArea}, ${place.street}";
      emit(state.copyWith(selectedLocation: location, searchResults: [], address: address));
      editEventCubit.stage2SetLocation(
          latitude: location.latitude, longitude: location.longitude, city: place.subAdministrativeArea??"", address: place.street??"");
    }

  }

  Future<void> noPermission() async {
    emit(state.copyWith(selectedLocation: LatLng(48.4613359, 35.0627361)));
  }

}
