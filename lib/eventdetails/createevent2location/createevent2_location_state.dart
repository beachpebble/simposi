part of 'createevent2_location_cubit.dart';

class CreateEvent2LocationState extends Equatable {
  const CreateEvent2LocationState(
      {required this.selectedLocation,
        required this.searchResults,
        required this.range});

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final double range;

  @override
  List<Object?> get props => [selectedLocation, searchResults, range];

  static CreateEvent2LocationState initial(double? range, double? latitude, double? longitude) {
    LatLng? location = (latitude != null && longitude != null) ?  LatLng(latitude, longitude) : null;
    return CreateEvent2LocationState(selectedLocation: location, searchResults: [], range: range ?? 1);
  }


  CreateEvent2LocationState copyWith(
      {LatLng? selectedLocation,
        List<PlacesSearchResult>? searchResults,
        double? range,
        bool ready = false}) {
    return CreateEvent2LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchResults: searchResults ?? this.searchResults,
      range: range ?? this.range,
    );
  }
}
