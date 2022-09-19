// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user_id', 'event_id', 'rate', 'text'],
    disallowNullValues: const ['user_id', 'event_id', 'rate', 'text'],
  );
  return Survey(
    userId: json['user_id'] as int,
    eventId: json['event_id'] as int,
    rate: json['rate'] as int,
    reportText: json['text'] as String?,
  );
}

Map<String, dynamic> _$SurveyToJson(Survey instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'event_id': instance.eventId,
    'rate': instance.rate,
  };

  void writeNotNull(String key, value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('text', instance.reportText);
  return val;
}
