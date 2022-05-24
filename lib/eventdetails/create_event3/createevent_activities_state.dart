part of 'createevent_activities_cubit.dart';

class CreateEventActivitiesState extends Equatable {
  const CreateEventActivitiesState(
      {this.selected = const {},
      required this.interests,
      this.filtered = const {}});

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;


  bool get nextEnabled => selected.isNotEmpty;

  CreateEventActivitiesState copyWith(
      {Set<Interest>? selected,
      Set<Interest>? interests,
      final Set<Interest>? filtered}) {
    return CreateEventActivitiesState(
        interests: interests ?? this.interests,
        selected: selected ?? this.selected,
        filtered: filtered ?? this.filtered,
        );
  }

  @override
  List<Object> get props => [selected, interests, filtered];

  @override
  bool? get stringify => true;
}
