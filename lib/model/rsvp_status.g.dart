// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rsvp_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RsvpStatus _$RsvpStatusFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title'],
    disallowNullValues: const ['id', 'title'],
  );
  return RsvpStatus(
    json['id'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$RsvpStatusToJson(RsvpStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
