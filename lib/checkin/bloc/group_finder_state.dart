part of 'group_finder_bloc.dart';

abstract class GroupFinderState extends Equatable {
  const GroupFinderState();

  @override
  List<Object?> get props => [];
}

class GroupFinderLoaded extends GroupFinderState {
  final GroupUserWithRange? userSelected;
  final List<GroupUserWithRange> users;
  final double startAngle;

  GroupFinderLoaded(this.userSelected, this.users, this.startAngle);

  @override
  List<Object?> get props => [userSelected, users, startAngle];
}

class GroupUserWithRange extends Equatable {
  final GroupFinderUser user;
  final double range;

  Range get rangeClass {
    if (range < 2)
      return Range.R1_2;
    else if (range < 10)
      return Range.R2_10;
    else
      return Range.R10_30;
  }

  GroupUserWithRange(this.user, this.range);

  @override
  List<Object?> get props => [user, range];
}

enum Range {
  R1_2,
  R2_10,
  R10_30,
}