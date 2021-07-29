part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {

}

// class RegistrationInitial extends RegistrationState {
//   final Set<RegistrationStage> stagesEnabledToNext;
//   Gender? gender;
//   Gender? wantToMeet;
//   Set<Generation>? generations;
//   Set<Earning>? earnings;
//   Set<Interest>? interests;
//   bool lgbt = false;
//   double? latitude;
//   double? longitude;
//   double? range;
//
//   RegistrationInitial(this.stagesEnabledToNext,
//       {Gender? gender,
//       Gender? wantToMeet,
//       Set<Generation>? generations,
//       Set<Earning>? earnings,
//       Set<Interest>? interests,
//       bool lgbt = false,
//       double? latitude,
//       double? longitude,
//       double? range});
//
//   RegistrationInitial copyWith(
//       {Gender? gender,
//       Gender? wantToMeet,
//       Set<Generation>? generations,
//       Set<Earning>? earnings,
//       Set<Interest>? interests,
//       bool? lgbt,
//       double? latitude,
//       double? longitude,
//       double? range}) {
//     return RegistrationInitial(
//       this.stagesEnabledToNext,
//       gender: gender ?? this.gender,
//       wantToMeet: wantToMeet ?? this.wantToMeet,
//       generations: generations ?? this.generations,
//       earnings: earnings ?? this.earnings,
//       interests: interests ?? this.interests,
//       lgbt: lgbt ?? this.lgbt,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       range: range ?? this.range,
//     );
//   }
// }

class RegistrationLoading extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final dynamic error;

  RegistrationError(this.error);

  @override
  List<Object> get props => [error];
}

class RegistrationWaitCode extends RegistrationState {
  final String token;
  final String phone;

  RegistrationWaitCode(this.token, this.phone);

  @override
  List<Object> get props => [token];
}
