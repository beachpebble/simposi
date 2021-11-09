part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileNotLoaded extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final dynamic error;

  ProfileLoadError(this.error);

  @override
  List<Object> get props => [error];
}
