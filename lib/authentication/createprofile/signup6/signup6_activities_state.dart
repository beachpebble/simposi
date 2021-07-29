part of 'signup6_activities_cubit.dart';

class Signup6ActivitiesState extends Equatable {
  const Signup6ActivitiesState({this.selected = const {},
    required this.interests,
    this.filtered = const {}});

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;

  bool get nextEnabled => selected.isNotEmpty;

  Signup6ActivitiesState copyWith({Set<Interest>? selected,
    Set<Interest>? interests,
    final Set<Interest>? filtered}) {
    return Signup6ActivitiesState(
      interests: interests ?? this.interests,
      selected: selected ?? this.selected,
      filtered: filtered ?? this.filtered,
    );
  }

  @override
  List<Object> get props => [selected,  filtered];

  bool? get stringify => true;
}
