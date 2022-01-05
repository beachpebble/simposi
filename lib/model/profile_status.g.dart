// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileStatus _$ProfileStatusFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'checked_in_event_id',
      'checked_in_event_date',
      'required_survey_by_users'
    ],
  );
  return ProfileStatus(
    eventId: json['checked_in_event_id'] as int?,
    eventDate: json['checked_in_event_date'] == null
        ? null
        : DateTime.parse(json['checked_in_event_date'] as String),
    surveyNeed: json['required_survey_by_users'] as bool,
  );
}

Map<String, dynamic> _$ProfileStatusToJson(ProfileStatus instance) =>
    <String, dynamic>{
      'checked_in_event_id': instance.eventId,
      'checked_in_event_date': instance.eventDate?.toIso8601String(),
      'required_survey_by_users': instance.surveyNeed,
    };
