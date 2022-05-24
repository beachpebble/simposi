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

  const GroupFinderLoaded(this.userSelected, this.users, this.startAngle);

  @override
  List<Object?> get props => [userSelected, users, startAngle];
}

class GroupFinderError extends GroupFinderState {
  final dynamic error;

  const GroupFinderError(this.error);

  @override
  List<Object> get props => [error];
}

class GroupFinderLocationError extends GroupFinderState {
}

class GroupFinderNoPermissions extends GroupFinderState {
}


class GroupUserWithRange extends Equatable {
  final GroupFinderUser user;
  final double range;

  Range get rangeClass {
    if (range < 2) {
      return Range.R1_2;
    } else if (range < 10) {
      return Range.R2_10;
    } else {
      return Range.R10_30;
    }
  }

  const GroupUserWithRange(this.user, this.range);

  @override
  List<Object?> get props => [user, range];
}

enum Range {
  R1_2,
  R2_10,
  R10_30,
}