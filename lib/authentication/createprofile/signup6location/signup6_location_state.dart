part of 'signup6_location_cubit.dart';

class Signup6LocationState extends Equatable {
  const Signup6LocationState(
      {required this.selectedLocation,
      required this.searchResults,
      required this.editMode,
      required this.rangeKm});

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final double rangeKm;
  final bool editMode;

  @override
  List<Object?> get props => [selectedLocation, searchResults, rangeKm];

  static Signup6LocationState initial(
      double? range, double? latitude, double? longitude, bool editMode) {
    final location = (latitude != null && longitude != null)
        ? LatLng(latitude, longitude)
        : null;
    return Signup6LocationState(
        selectedLocation: location, searchResults: const [], rangeKm: range ?? 1, editMode: editMode);
  }

  Signup6LocationState copyWith(
      {LatLng? selectedLocation,
      List<PlacesSearchResult>? searchResults,
      double? range,
      bool ready = false}) {
    return Signup6LocationState(
        selectedLocation: selectedLocation ?? this.selectedLocation,
        searchResults: searchResults ?? this.searchResults,
        rangeKm: range ?? rangeKm,
        editMode: editMode);
  }
}

class Signup6LocationStateLoading extends Signup6LocationState {
  Signup6LocationStateLoading({required Signup6LocationState state})
      : super(
            selectedLocation: state.selectedLocation,
            searchResults: state.searchResults,
            rangeKm: state.rangeKm,
            editMode: state.editMode);
}

class Signup6LocationStateSuccess extends Signup6LocationState {
  Signup6LocationStateSuccess({required Signup6LocationState state})
      : super(
            selectedLocation: state.selectedLocation,
            searchResults: state.searchResults,
            rangeKm: state.rangeKm,
            editMode: state.editMode);
}

class Signup6LocationStateError extends Signup6LocationState {
  Signup6LocationStateError({required Signup6LocationState state, this.error})
      : super(
            selectedLocation: state.selectedLocation,
            searchResults: state.searchResults,
            rangeKm: state.rangeKm,
            editMode: state.editMode);

  final dynamic error;
}
