part of 'createevent2_location_cubit.dart';

class CreateEvent2LocationState extends Equatable {
  const CreateEvent2LocationState(
      {required this.selectedLocation,
        required this.searchResults,
        required this.address,

      });

  final LatLng? selectedLocation;
  final List<PlacesSearchResult> searchResults;
  final String? address;

  @override
  List<Object?> get props => [selectedLocation, searchResults, address];

  static CreateEvent2LocationState initial(double? latitude, double? longitude) {
    LatLng? location = (latitude != null && longitude != null) ?  LatLng(latitude, longitude) : null;
    return CreateEvent2LocationState(selectedLocation: location, searchResults: [], address: null );
  }


  CreateEvent2LocationState copyWith(
      {LatLng? selectedLocation,
        List<PlacesSearchResult>? searchResults,
        String? address,
        }) {
    return CreateEvent2LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchResults: searchResults ?? this.searchResults,
      address: address ?? this.address,
    );
  }
}
