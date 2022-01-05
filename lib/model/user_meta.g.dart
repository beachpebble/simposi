// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeta _$UserMetaFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'wtm_genders',
      'wtm_generations',
      'wtm_earnings',
      'wtm_interests',
      'wtm_lgbt'
    ],
  );
  return UserMeta(
    wantToMeetGender: (json['wtm_genders'] as List<dynamic>)
        .map((e) => Gender.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetGenerations: (json['wtm_generations'] as List<dynamic>)
        .map((e) => Generation.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetEarnings: (json['wtm_earnings'] as List<dynamic>)
        .map((e) => Earning.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetLgbt: json['wtm_lgbt'] as bool,
    wantToMeetInterests: (json['wtm_interests'] as List<dynamic>)
        .map((e) => Interest.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserMetaToJson(UserMeta instance) => <String, dynamic>{
      'wtm_genders': instance.wantToMeetGender,
      'wtm_generations': instance.wantToMeetGenerations,
      'wtm_earnings': instance.wantToMeetEarnings,
      'wtm_interests': instance.wantToMeetInterests,
      'wtm_lgbt': instance.wantToMeetLgbt,
    };
