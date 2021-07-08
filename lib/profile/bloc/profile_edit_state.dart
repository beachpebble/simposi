part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

class ProfileEditInitial extends ProfileEditState {
}

class ProfileEditLoading extends ProfileEditState {
}

class ProfileEditError extends ProfileEditState {
  final dynamic error;

  ProfileEditError(this.error);

  @override
  List<Object> get props => [error];
}

class ProfileEditSuccess extends ProfileEditState {

}
