part of 'signup5_activities_cubit.dart';

class Signup5ActivitiesState extends Equatable {
  const Signup5ActivitiesState({this.selected = const {},
    required this.interests,
    this.filtered = const {}, required this.editMode });

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;
  final bool editMode;

  bool get nextEnabled => selected.isNotEmpty;

  Signup5ActivitiesState copyWith({Set<Interest>? selected,
    Set<Interest>? interests,
    final Set<Interest>? filtered}) {
    return Signup5ActivitiesState(
      interests: interests ?? this.interests,
      selected: selected ?? this.selected,
      filtered: filtered ?? this.filtered,
      editMode: this.editMode
    );
  }

  @override
  List<Object> get props => [selected, interests, filtered];

  bool? get stringify => true;
}
