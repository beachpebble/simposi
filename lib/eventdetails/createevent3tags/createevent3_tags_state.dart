part of 'createevent3_tags_cubit.dart';

class CreateEvent3TagsState extends Equatable {
  const CreateEvent3TagsState({this.selected = const {},
    required this.interests,
    this.filtered = const {}});

  final Set<Interest> selected;
  final Set<Interest> interests;
  final Set<Interest> filtered;

  bool get nextEnabled => selected.isNotEmpty;

  CreateEvent3TagsState copyWith({Set<Interest>? selected,
    Set<Interest>? interests,
    final Set<Interest>? filtered}) {
    return CreateEvent3TagsState(
      interests: interests ?? this.interests,
      selected: selected ?? this.selected,
      filtered: filtered ?? this.filtered,
    );
  }

  @override
  List<Object> get props => [selected, interests, filtered];

  bool? get stringify => true;
}
