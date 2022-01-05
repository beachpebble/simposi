// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Earning _$EarningFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title', 'sort'],
    disallowNullValues: const ['id', 'title', 'sort'],
  );
  return Earning(
    id: json['id'] as int,
    title: json['title'] as String,
    sortId: json['sort'] as int,
  );
}

Map<String, dynamic> _$EarningToJson(Earning instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sort': instance.sortId,
    };
