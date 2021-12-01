part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {
  const FcmEvent();

  @override
  List<Object?> get props => [];
}

class FcmNewToken extends FcmEvent {
  final String token;

  FcmNewToken(this.token);

  @override
  List<Object?> get props => [token];
}
class NewRsvp extends FcmEvent {

}
