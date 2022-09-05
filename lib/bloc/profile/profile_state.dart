part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileNotLoaded extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile userProfile;

  const ProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ProfileOnEvent extends ProfileLoaded {
  const ProfileOnEvent(Profile userProfile, this.event) : super(userProfile);

  final Event event;

  @override
  List<Object> get props => [userProfile, event];
}

class ProfileOnSurvey extends ProfileLoaded {
  const ProfileOnSurvey(Profile userProfile) : super(userProfile);
}

class ProfileEditLoading extends ProfileLoaded {
  const ProfileEditLoading(Profile userProfile) : super(userProfile);
}

class ProfileEditSuccess extends ProfileLoaded {
  const ProfileEditSuccess(Profile userProfile) : super(userProfile);
}

class ProfileEditError extends ProfileLoaded {
  final dynamic error;

  const ProfileEditError(Profile userProfile, this.error) : super(userProfile);

  @override
  List<Object> get props => [userProfile, error];
}

class ProfileLoading extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final dynamic error;

  const ProfileLoadError(this.error);

  @override
  List<Object> get props => [error];
}
