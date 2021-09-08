part of 'signup5_activities_cubit.dart';

class Signup5ActivitiesState extends Equatable {
  const Signup5ActivitiesState(
      {this.selected = const {},
      required this.interests,
      this.filtered = const {},
      required this.editMode,
      required this.loading,
      this.error});

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;
  final bool editMode;
  final bool loading;
  final dynamic error;

  bool get nextEnabled => selected.isNotEmpty;

  Signup5ActivitiesState copyWith(
      {Set<Interest>? selected,
      Set<Interest>? interests,
      final Set<Interest>? filtered,
      bool? loading,
      dynamic error}) {
    return Signup5ActivitiesState(
        interests: interests ?? this.interests,
        selected: selected ?? this.selected,
        filtered: filtered ?? this.filtered,
        editMode: this.editMode,
        loading: loading ?? this.loading,
        error: error);
  }

  @override
  List<Object> get props => [selected, interests, filtered, loading];

  bool? get stringify => true;
}

class Signup5ActivitiesStateSuccessChange extends Signup5ActivitiesState {
  const Signup5ActivitiesStateSuccessChange(
      {required Set<Interest> selected,
      required Set<Interest> interests,
      required Set<Interest> filtered,
      required bool editMode,
      required bool loading,
      final dynamic error})
      : super(
            selected: selected,
            interests: interests,
            filtered: filtered,
            editMode: editMode,
            error: error,
            loading: loading);

  static Signup5ActivitiesStateSuccessChange copyFrom(
      {required Signup5ActivitiesState state}) {
    return Signup5ActivitiesStateSuccessChange(
        interests: state.interests,
        selected: state.selected,
        filtered: state.filtered,
        editMode: state.editMode,
        loading: false);
  }
}
