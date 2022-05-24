import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

part 'rsvp.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Rsvp extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'event', required: true, disallowNullValue: true)
  final Event event;
  @JsonKey(name: 'status', required: true, disallowNullValue: true)
  final RsvpStatus status;

  DateTime get fullDate => event.datetime.toLocal();
  DateTime get date => normalizeDate(event.datetime);
  String get title => event.title;
  String get image => event.image.url;

  const Rsvp({
    required this.id,
    required this.event,
    required this.status,
  });


  @override
  List<Object?> get props => [id, event, status];

  factory Rsvp.fromJson(Map<String, dynamic> json) => _$RsvpFromJson(json);

  Map<String, dynamic> toJson() => _$RsvpToJson(this);
}
