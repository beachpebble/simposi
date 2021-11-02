import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

part 'rsvp.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Rsvp extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'event', required: true, disallowNullValue: true)
  final Event event;

  get fullDate => event.datetime;
  get date => normalizeDate(event.datetime.toUtc());
  get title => event.title;
  get image => event.image.url;

  Rsvp({
    required this.id,
    required this.event,
  });

  @override
  List<Object?> get props => [id, event];

  factory Rsvp.fromJson(Map<String, dynamic> json) => _$RsvpFromJson(json);

  Map<String, dynamic> toJson() => _$RsvpToJson(this);
}
