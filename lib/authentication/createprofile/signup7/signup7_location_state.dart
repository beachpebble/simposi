part of 'signup7_location_cubit.dart';

class Signup7LocationState extends Equatable {
  const Signup7LocationState(
      {required this.selectedLocation,
      required this.searchResults,
      required this.range});

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final double range;

  @override
  List<Object?> get props => [selectedLocation, searchResults, range];

  static Signup7LocationState initial(double? range, double? latitude, double? longitude) {
    LatLng? location = (latitude != null && longitude != null) ?  LatLng(latitude, longitude) : null;
    return Signup7LocationState(selectedLocation: location, searchResults: [], range: range ?? 1);
  }


  Signup7LocationState copyWith(
      {LatLng? selectedLocation,
      List<PlacesSearchResult>? searchResults,
      double? range,
      bool ready = false}) {
    return Signup7LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchResults: searchResults ?? this.searchResults,
      range: range ?? this.range,
    );
  }
}
