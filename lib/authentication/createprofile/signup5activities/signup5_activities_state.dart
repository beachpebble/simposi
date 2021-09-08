part of 'signup5_activities_cubit.dart';

class Signup5ActivitiesState extends Equatable {
  const Signup5ActivitiesState(
      {this.selected = const {},
      required this.interests,
      this.filtered = const {},
      required this.editMode});

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;
  final bool editMode;


  bool get nextEnabled => selected.isNotEmpty;

  Signup5ActivitiesState copyWith(
      {Set<Interest>? selected,
      Set<Interest>? interests,
      final Set<Interest>? filtered}) {
    return Signup5ActivitiesState(
        interests: interests ?? this.interests,
        selected: selected ?? this.selected,
        filtered: filtered ?? this.filtered,
        editMode: this.editMode);
  }

  @override
  List<Object> get props => [selected, interests, filtered];

  bool? get stringify => true;
}

class Signup5ActivitiesStatLoading extends Signup5ActivitiesState {
  Signup5ActivitiesStatLoading(
      {required Signup5ActivitiesState state})
      : super(
      selected: state.selected,
      interests: state.interests,
      filtered: state.filtered,
      editMode: state.editMode,
  );
}


class Signup5ActivitiesStateSuccessChange extends Signup5ActivitiesState {
  Signup5ActivitiesStateSuccessChange(
      {required Signup5ActivitiesState state})
      : super(
            selected: state.selected,
            interests: state.interests,
            filtered: state.filtered,
            editMode: state.editMode,
            );
}

class Signup5ActivitiesStateErrorChange extends Signup5ActivitiesState {
  Signup5ActivitiesStateErrorChange(
      {required Signup5ActivitiesState state, this.error})
      : super(
      selected: state.selected,
      interests: state.interests,
      filtered: state.filtered,
      editMode: state.editMode,
  );

  final dynamic error;
}
