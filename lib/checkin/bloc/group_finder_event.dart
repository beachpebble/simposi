part of 'group_finder_bloc.dart';

abstract class GroupFinderEvent extends Equatable {
  const GroupFinderEvent();

  @override
  List<Object?> get props => [];
}

class GroupFinderMyLocationChanged extends GroupFinderEvent {
  final Position position;

  GroupFinderMyLocationChanged(this.position);

  @override
  List<Object?> get props => [position];
}

class GroupFinderUserListUpdated extends GroupFinderEvent {
  final List<GroupFinderUser> users;

  GroupFinderUserListUpdated(this.users);

  @override
  List<Object?> get props => [users];
}

class GroupFinderUserSelect extends GroupFinderEvent {
  final GroupUserWithRange user;

  GroupFinderUserSelect(this.user);

  @override
  List<Object?> get props => [user];
}
