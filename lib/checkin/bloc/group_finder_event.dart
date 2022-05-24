part of 'group_finder_bloc.dart';

abstract class GroupFinderEvent extends Equatable {
  const GroupFinderEvent();

  @override
  List<Object?> get props => [];
}

class GroupFinderMyLocationChanged extends GroupFinderEvent {
  final Position position;

  const GroupFinderMyLocationChanged(this.position);

  @override
  List<Object?> get props => [position];
}

class GroupFinderUserListUpdated extends GroupFinderEvent {
  final List<GroupFinderUser> users;

  const GroupFinderUserListUpdated(this.users);

  @override
  List<Object?> get props => [users];
}

class GroupFinderUserSelect extends GroupFinderEvent {
  final GroupUserWithRange user;

  const GroupFinderUserSelect(this.user);

  @override
  List<Object?> get props => [user];
}

class GroupFinderLocationEnabled extends GroupFinderEvent {
}

class GroupFinderLocationDisabled extends GroupFinderEvent {
}
class GroupFinderPermissionLost extends GroupFinderEvent {
}class GroupFinderPermissionRefresh extends GroupFinderEvent {
}

class GroupFinderErrorEvent extends GroupFinderEvent {
  final dynamic error;

  const GroupFinderErrorEvent(this.error);

  @override
  List<Object> get props => [error];
}