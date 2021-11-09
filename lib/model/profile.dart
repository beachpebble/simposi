import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/image.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/user_meta.dart';
import 'package:simposi_app_v4/utils/type_utils.dart';

import 'errors.dart';
import 'generation.dart';

part 'profile.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Profile extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int userId;
  @JsonKey(name: 'name', required: true, disallowNullValue: true)
  final String userName;
  @JsonKey(name: 'phone', required: true, disallowNullValue: true)
  final String userPhone;
  @JsonKey(name: 'facebook_url', required: false, disallowNullValue: false)
  final String? facebook;
  @JsonKey(name: 'instagram', required: false, disallowNullValue: false)
  final String? instagram;
  @JsonKey(name: 'linkedin_url', required: false, disallowNullValue: false)
  final String? linkedin;
  @JsonKey(name: 'profile_photo', required: false, disallowNullValue: false)
  final Image profilePhoto;
  @JsonKey(name: 'is_lgbtq', required: true, disallowNullValue: true)
  final bool isLgbt;
  @JsonKey(name: 'gender', required: true, disallowNullValue: true, fromJson: _genderFromJson)
  final Gender gender;
  @JsonKey(name: 'generations_identity_id', required: true, disallowNullValue: true)
  final int generationId;
  @JsonKey(name: 'who_earns', required: true, disallowNullValue: true)
  final List<Earning> earnings;
  @JsonKey(name: 'what_you_likes', required: true, disallowNullValue: true)
  final List<Interest> interests;
  @JsonKey(name: 'latitude', required: true, disallowNullValue: true)
  final String latitude;
  @JsonKey(name: 'longitude', required: true, disallowNullValue: true)
  final String longitude;
  @JsonKey(name: 'distance', required: true, disallowNullValue: true)
  final String range;
  @JsonKey(name: 'emergency_contact_name', required: true, disallowNullValue: false)
  final String? emergencyContactName;
  @JsonKey(name: 'emergency_contact_phone', required: true, disallowNullValue: false)
  final String? emergencyContactPhone;
  @JsonKey(name: 'meta_data', required: true, disallowNullValue: false)
  final UserMeta? userMeta;


  Profile({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.profilePhoto,
    required this.isLgbt,
    required this.gender,
    required this.generationId,
    required this.earnings,
    required this.interests,
    required this.latitude,
    required this.longitude,
    required this.range,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.userMeta,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
        userPhone,
        profilePhoto,
        generationId,
        earnings,
        interests,
        latitude,
        longitude,
        range,
        emergencyContactName,
        emergencyContactPhone,
        userMeta,
      ];

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  // static Profile fromJson(Map json) {
  //   int? parsedUserId = json.containsKey('id') ? json['id'] : null;
  //   String? parsedUserName = json.containsKey('name') ? json['name'] : null;
  //   Map? parsedProfilePhoto =
  //       json.containsKey('profile_photo') ? json['profile_photo'] : null;
  //   // String? parsedWantToMeet =
  //   //     json.containsKey('want_to_meets') ? json['want_to_meets'] : null;
  //   String? parsedGenderId = json.containsKey('gender') ? json['gender'] : null;
  //   bool parsedIsLgbt = json.containsKey('is_lgbtq') && json['is_lgbtq'] != null
  //       ? json['is_lgbtq']
  //       : false;
  //   String? parsedFacebook =
  //       json.containsKey('facebook_url') ? json['facebook_url'] : null;
  //   String? parsedInstagram =
  //       json.containsKey('instagram') ? json['instagram'] : null;
  //   String? parsedLinkedin =
  //       json.containsKey('linkedin_url') ? json['linkedin_url'] : null;
  //
  //   String? parsedPhone = json.containsKey('phone') ? json['phone'] : null;
  //
  //   String? parsedLatitude =
  //       json.containsKey('latitude') ? json['latitude'] : null;
  //   String? parsedLongitude =
  //       json.containsKey('longitude') ? json['longitude'] : null;
  //   double? parsedDistance =
  //       json.containsKey('distance') ? checkDouble(json['distance']) : null;
  //
  //   int? generations = json.containsKey('generations_identity_id')
  //       ? json['generations_identity_id']
  //       : null;
  //   List earningsStr = json.containsKey('who_earns') ? json['who_earns'] : [];
  //   Set<Earning> earnings = earningsStr.map((e) => Earning.fromJson(e)).toSet();
  //   List interestsStr =
  //       json.containsKey('what_you_likes') ? json['what_you_likes'] : [];
  //   Set<Interest> interests =
  //       interestsStr.map((e) => Interest.fromJson(e)).toSet();
  //
  //   String? parsedEmergencyContactName =
  //       json.containsKey('emergency_contact_name')
  //           ? json['emergency_contact_name']
  //           : null;
  //   ;
  //   String? parsedEmergencyContactPhone =
  //       json.containsKey('emergency_contact_phone')
  //           ? json['emergency_contact_phone']
  //           : null;
  //   ;
  //
  //   if (parsedUserId == null ||
  //       parsedUserName == null ||
  //       parsedGenderId == null ||
  //       parsedLatitude == null ||
  //       parsedLongitude == null ||
  //       parsedPhone == null ||
  //       parsedDistance == null ||
  //       parsedProfilePhoto == null ||
  //       generations == null)
  //     throw ParseException(message: "Incorrect data structure");
  //
  //   Gender? gender = Gender.fromId(parsedGenderId);
  //   if (gender == null)
  //     throw ParseException(message: "Incorrect data structure");
  //
  //   return Profile(
  //     userId: parsedUserId,
  //     userName: parsedUserName,
  //     userPhone: parsedPhone,
  //     profilePhoto: parsedProfilePhoto['url'],
  //     wantToMeet: "",
  //     emergencyContactName: parsedEmergencyContactName,
  //     emergencyContactPhone: parsedEmergencyContactPhone,
  //     isLgbt: parsedIsLgbt,
  //     gender: gender,
  //     facebook: parsedFacebook,
  //     instagram: parsedInstagram,
  //     linkedin: parsedLinkedin,
  //     interests: interests,
  //     earnings: earnings,
  //     generationId: generations,
  //     longitude: double.parse(parsedLongitude),
  //     latitude: double.parse(parsedLatitude),
  //     range: parsedDistance,
  //   );
  // }
}

Gender _genderFromJson(int json) => json == 1 ? Gender.Male : Gender.Female;