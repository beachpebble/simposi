// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_required.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyRequired _$SurveyRequiredFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'user_id',
      'user_name',
      'user_photo',
      'event_id',
      'event_name',
      'event_date'
    ],
    disallowNullValues: const [
      'id',
      'user_id',
      'user_name',
      'user_photo',
      'event_id',
      'event_name',
      'event_date'
    ],
  );
  return SurveyRequired(
    id: json['id'] as int,
    userName: json['user_name'] as String,
    userPhoto: json['user_photo'] as String,
    eventId: json['event_id'] as int,
    eventName: json['event_name'] as String,
    eventDate: DateTime.parse(json['event_date'] as String),
    userId: json['user_id'] as int,
  );
}

Map<String, dynamic> _$SurveyRequiredToJson(SurveyRequired instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_photo': instance.userPhoto,
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_date': instance.eventDate.toIso8601String(),
    };
