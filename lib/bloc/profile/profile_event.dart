part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileReload extends ProfileEvent {
  ProfileReload();
}

class ProfileUpdateMainFields extends ProfileEvent {
  final String? name;
  final String? phone;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String? filePath;

  ProfileUpdateMainFields(
      {this.name,
      this.phone,
      this.facebook,
      this.instagram,
      this.linkedin,
      this.filePath});

  @override
  List<Object?> get props =>
      [name, phone, facebook, instagram, linkedin, filePath];
}

class ProfileUpdateIndentifyAs extends ProfileEvent {
  final Gender gender;
  final bool isLgbt;

  ProfileUpdateIndentifyAs({required this.gender, required this.isLgbt});

  @override
  List<Object?> get props => [gender, isLgbt];
}

class ProfileUpdateGeneration extends ProfileEvent {
  final int generation;

  ProfileUpdateGeneration({required this.generation});

  @override
  List<Object?> get props => [generation];
}

class ProfileUpdateInterests extends ProfileEvent {
  final Set<Interest> interests;

  ProfileUpdateInterests({required this.interests});

  @override
  List<Object?> get props => [interests];
}

class ProfileUpdateLocation extends ProfileEvent {
  final double latitude;
  final double longitude;
  final double range;

  ProfileUpdateLocation(this.latitude, this.longitude, this.range);

  @override
  List<Object?> get props => [latitude, longitude, range];
}

class ProfileUpdateIncome extends ProfileEvent {
  final Set<Earning> earnings;

  ProfileUpdateIncome(this.earnings);

  @override
  List<Object?> get props => [earnings];
}

class ProfileUpdateEmergencyContact extends ProfileEvent {
  final String name;
  final String phone;

  ProfileUpdateEmergencyContact({required this.name, required this.phone});

  @override
  List<Object?> get props => [name, phone];
}

class ProfileUpdateWantToMeetGeneration extends ProfileEvent {
  final List<Generation> generations;

  ProfileUpdateWantToMeetGeneration(this.generations);

  @override
  List<Object?> get props => [generations];
}

class ProfileUpdateWantToMeetIncome extends ProfileEvent {
  final List<Earning> earnings;

  ProfileUpdateWantToMeetIncome(this.earnings);

  @override
  List<Object?> get props => [earnings];
}

class ProfileUpdateWantToMeetGender extends ProfileEvent {
  final List<Gender> gender;
  final bool isLgbt;

  ProfileUpdateWantToMeetGender({required this.gender, required this.isLgbt});

  @override
  List<Object?> get props => [gender, isLgbt];
}
