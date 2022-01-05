// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'phone',
      'is_lgbtq',
      'gender',
      'generations_identity_id',
      'who_earns',
      'what_you_likes',
      'latitude',
      'longitude',
      'distance',
      'emergency_contact_name',
      'emergency_contact_phone',
      'meta_data'
    ],
    disallowNullValues: const [
      'id',
      'name',
      'phone',
      'is_lgbtq',
      'gender',
      'generations_identity_id',
      'who_earns',
      'what_you_likes',
      'latitude',
      'longitude',
      'distance'
    ],
  );
  return Profile(
    userId: json['id'] as int,
    userName: json['name'] as String,
    userPhone: json['phone'] as String,
    profilePhoto: Image.fromJson(json['profile_photo'] as Map<String, dynamic>),
    isLgbt: json['is_lgbtq'] as bool,
    gender: _genderFromJson(json['gender'] as int),
    generationId: json['generations_identity_id'] as int,
    earnings: (json['who_earns'] as List<dynamic>)
        .map((e) => Earning.fromJson(e as Map<String, dynamic>))
        .toList(),
    interests: (json['what_you_likes'] as List<dynamic>)
        .map((e) => Interest.fromJson(e as Map<String, dynamic>))
        .toList(),
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    range: json['distance'] as String,
    facebook: json['facebook_url'] as String?,
    instagram: json['instagram'] as String?,
    linkedin: json['linkedin_url'] as String?,
    emergencyContactName: json['emergency_contact_name'] as String?,
    emergencyContactPhone: json['emergency_contact_phone'] as String?,
    userMeta: json['meta_data'] == null
        ? null
        : UserMeta.fromJson(json['meta_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.userId,
      'name': instance.userName,
      'phone': instance.userPhone,
      'facebook_url': instance.facebook,
      'instagram': instance.instagram,
      'linkedin_url': instance.linkedin,
      'profile_photo': instance.profilePhoto,
      'is_lgbtq': instance.isLgbt,
      'gender': instance.gender,
      'generations_identity_id': instance.generationId,
      'who_earns': instance.earnings,
      'what_you_likes': instance.interests,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.range,
      'emergency_contact_name': instance.emergencyContactName,
      'emergency_contact_phone': instance.emergencyContactPhone,
      'meta_data': instance.userMeta,
    };
