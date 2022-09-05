part of 'fcm_bloc.dart';

abstract class FcmState extends Equatable {
  const FcmState();

  @override
  List<Object> get props => [];
}

class FcmInitial extends FcmState {

}

class FcmTokenUpdated extends FcmState {
  final String token;

  const FcmTokenUpdated(this.token);

  @override
  List<Object> get props => [token];
}

class NewRsvpReceived extends FcmState {

}

