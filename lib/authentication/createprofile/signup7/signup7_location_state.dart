part of 'signup7_location_cubit.dart';

class Signup7LocationState extends Equatable {
  const Signup7LocationState(
      {required this.selectedLocation, required this.searchResults, required this.range, required this.ready});

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final double range;
  final bool ready;


  @override
  List<Object?> get props => [selectedLocation, searchResults, range, ready];

  static Signup7LocationState initial() => Signup7LocationState(selectedLocation: null, searchResults: [], range: 1, ready: false);

  Signup7LocationState copyWith({LatLng? selectedLocation, List<
      PlacesSearchResult>? searchResults, double? range, bool ready = false}) {
    return Signup7LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchResults: searchResults ?? this.searchResults,
      range: range ?? this.range,
      ready: ready ,
    );
  }
}
