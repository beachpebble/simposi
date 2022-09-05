// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_finder_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupFinderUser _$GroupFinderUserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'photo', 'longitude', 'latitude'],
    disallowNullValues: const ['id', 'name', 'photo', 'longitude', 'latitude'],
  );
  return GroupFinderUser(
    id: json['id'] as int,
    name: json['name'] as String,
    imageUrl: json['photo'] as String,
    longitude: json['longitude'] as String,
    latitude: json['latitude'] as String,
  );
}

Map<String, dynamic> _$GroupFinderUserToJson(GroupFinderUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.imageUrl,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
