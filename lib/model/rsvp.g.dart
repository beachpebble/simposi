// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rsvp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rsvp _$RsvpFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'event', 'status'],
    disallowNullValues: const ['id', 'event', 'status'],
  );
  return Rsvp(
    id: json['id'] as int,
    event: Event.fromJson(json['event'] as Map<String, dynamic>),
    status: RsvpStatus.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RsvpToJson(Rsvp instance) => <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'status': instance.status,
    };
