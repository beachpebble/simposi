import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';

part 'signup7_location_state.dart';

class Signup7LocationCubit extends Cubit<Signup7LocationState> {
  Signup7LocationCubit({required this.registrationCubit}) : super(Signup7LocationState.initial()) {
    regSubscription = registrationCubit.stream.listen((state) {
      if (state is RegistrationStage8) {
        emit(this.state.copyWith(ready: true));
      }
    });
  }

  final RegistrationCubit registrationCubit;
  late StreamSubscription regSubscription;

  @override
  Future<void> close() {
    regSubscription.cancel();
    return super.close();
  }

  //TODO move keys to one place
  final places =
  new GoogleMapsPlaces(apiKey: "AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI");

  Future<void> searchPlace(String searchStr) async {
    PlacesSearchResponse response = await places.searchByText(searchStr);
    emit(state.copyWith(searchResults: response.results));
  }

  Future<void> selectLocation(LatLng location) async {
    emit(state.copyWith(selectedLocation: location, searchResults: []));
  }

  Future<void> noPermission() async {
    emit(state.copyWith(selectedLocation: LatLng(48.4613359, 35.0627361)));
  }

  Future<void> selectRange(double range) async {
    emit(state.copyWith(range: range));
  }

  Future<void> submit() async {
    if (state.selectedLocation != null)
    registrationCubit.stage7(latitude: state.selectedLocation!.latitude, longitude: state.selectedLocation!.longitude, range: state.range);
  }

}
