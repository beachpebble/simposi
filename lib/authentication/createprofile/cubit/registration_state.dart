part of 'registration_cubit.dart';

abstract class RegistrationState {}

class RegistrationStageLoadingData extends RegistrationState {}

class RegistrationStageLoadingDataError extends RegistrationState
    implements Equatable {
  final dynamic error;

  RegistrationStageLoadingDataError(this.error);

  @override
  List<Object> get props => [error];

  @override
  bool? get stringify => true;
}

class RegistrationStage1 extends RegistrationState implements Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class RegistrationStage1Loading extends RegistrationState {}

class RegistrationStage1Error extends RegistrationState implements Equatable {
  final dynamic error;

  RegistrationStage1Error(this.error);

  @override
  List<Object> get props => [error];

  @override
  bool? get stringify => true;
}

class RegistrationStage2 extends RegistrationState {}

class RegistrationStage3 extends RegistrationState implements Equatable {
  final Gender selectedGender;

  RegistrationStage3(this.selectedGender);

  @override
  List<Object> get props => [selectedGender];

  @override
  bool? get stringify => true;
}

class RegistrationStage4 extends RegistrationState {}

class RegistrationStage5 extends RegistrationState {}

class RegistrationStage6 extends RegistrationState {
  final List<Interest> interests;

  RegistrationStage6(this.interests);
}

class RegistrationStage7 extends RegistrationState {
}
