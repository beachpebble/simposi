import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/rsvp.dart';

class EventModel extends Equatable {
  final DateTime normalizedDate;
  final Rsvp rsvp;
  final bool isMine;

  EventModel({
    required this.normalizedDate,
    required this.rsvp,
    required this.isMine,
  });

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

  @override
  List<Object?> get props => [normalizedDate, rsvp, isMine];
}
