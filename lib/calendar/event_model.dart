import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';

class EventModel extends Equatable {
  final DateTime normalizedDate;
  final Rsvp rsvp;
  final bool isMine;

  EventModel({
    required this.normalizedDate,
    required this.rsvp,
    required int myId,
  }): isMine = rsvp.event.userId == myId;

      String get addressRepresentaion => "${rsvp.event.locationAddress}, ${rsvp.event.locationCity}";

  String get generationsString => rsvp.event.wantToMeetGenerations.map((e) => e.title).join(", ");
  String get earningsString => rsvp.event.wantToMeetEarnings.map((e) => e.title).join(", ");
  String get gendersString {
    var values = <String>[];
    if (rsvp.event.wantToMeetGenders.contains(Gender.Male))
      values.add("Men");
    if (rsvp.event.wantToMeetGenders.contains(Gender.Female))
      values.add("Women");
    if (rsvp.event.isLgbt)
      values.add("LGBT");
    return values.join(", ");
  }

  double? get latitude =>double.parse(rsvp.event.latitude);
  double? get longitude =>double.parse(rsvp.event.longitude);

  bool get showInvite => !isMine && [RsvpStatus.INVITED_ID, RsvpStatus.OPENED_ID].contains(rsvp.status.id);
  bool get showGoing => [RsvpStatus.ACCEPTED].contains(rsvp.status.title);
  bool get showCheckIn => [RsvpStatus.ACCEPTED].contains(rsvp.status.title) || isMine;

  @override
  List<Object?> get props => [normalizedDate, rsvp, isMine];

  @override
  bool get stringify {
    return false;
  }
}
