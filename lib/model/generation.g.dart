// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Generation _$GenerationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title'],
    disallowNullValues: const ['id', 'title'],
  );
  return Generation(
    id: json['id'] as int,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$GenerationToJson(Generation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
