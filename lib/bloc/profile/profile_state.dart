part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileNotLoaded extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile userProfile;

  ProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ProfileEditLoading extends ProfileLoaded {
  ProfileEditLoading(Profile userProfile) : super(userProfile);
}

class ProfileEditSuccess extends ProfileLoaded {
  ProfileEditSuccess(Profile userProfile) : super(userProfile);
}

class ProfileEditError extends ProfileLoaded {
  final dynamic error;

  ProfileEditError(Profile userProfile, this.error) : super(userProfile);

  @override
  List<Object> get props => [userProfile, error];
}

class ProfileLoading extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final dynamic error;

  ProfileLoadError(this.error);

  @override
  List<Object> get props => [error];
}
