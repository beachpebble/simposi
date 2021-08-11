part of 'signup6_location_cubit.dart';

class Signup6LocationState extends Equatable {
  const Signup6LocationState(
      {required this.selectedLocation,
        required this.searchResults,
        required this.range});

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final double range;

  @override
  List<Object?> get props => [selectedLocation, searchResults, range];

  static Signup6LocationState initial(double? range, double? latitude, double? longitude) {
    LatLng? location = (latitude != null && longitude != null) ?  LatLng(latitude, longitude) : null;
    return Signup6LocationState(selectedLocation: location, searchResults: [], range: range ?? 1);
  }


  Signup6LocationState copyWith(
      {LatLng? selectedLocation,
        List<PlacesSearchResult>? searchResults,
        double? range,
        bool ready = false}) {
    return Signup6LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchResults: searchResults ?? this.searchResults,
      range: range ?? this.range,
    );
  }
}
