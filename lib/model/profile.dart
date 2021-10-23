import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/utils/type_utils.dart';

import 'errors.dart';

class Profile extends Equatable {
  final int userId;
  final String userName;
  final String userPhone;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String profilePhoto;
  final String? wantToMeet;
  final bool isLgbt;
  final Gender gender;
  final int generationId;
  final Set<Earning> earnings;
  final Set<Interest> interests;
  final double latitude;
  final double longitude;
  final double range;

  Profile({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.profilePhoto,
    required this.isLgbt,
    required this.gender,
    required this.wantToMeet,
    required this.generationId,
    required this.earnings,
    required this.interests,
    required this.latitude,
    required this.longitude,
    required this.range,
    this.facebook,
    this.instagram,
    this.linkedin,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
        userPhone,
        profilePhoto,
        wantToMeet,
        generationId,
        earnings,
        interests,
        latitude,
        longitude,
        range
      ];

  static Profile fromJson(Map json) {
    developer.log("Profile loading from json $json");
    int? parsedUserId = json.containsKey('id') ? json['id'] : null;
    String? parsedUserName = json.containsKey('name') ? json['name'] : null;
    String? parsedProfilePhoto =
        json.containsKey('profile_photo') ? json['profile_photo'] : null;
    String? parsedWantToMeet =
        json.containsKey('want_to_meets') ? json['want_to_meets'] : null;
    String? parsedGenderId = json.containsKey('gender') ? json['gender'] : null;
    bool parsedIsLgbt = json.containsKey('is_lgbtq') && json['is_lgbtq'] != null
        ? json['is_lgbtq']
        : false;
    String? parsedFacebook =
        json.containsKey('facebook_url') ? json['facebook_url'] : null;
    String? parsedInstagram =
        json.containsKey('instagram__url') ? json['instagram__url'] : null;
    String? parsedLinkedin =
        json.containsKey('linkedln__url') ? json['linkedln__url'] : null;

    String? parsedPhone = json.containsKey('phone') ? json['phone'] : null;

    String? parsedLatitude =
        json.containsKey('latitude') ? json['latitude'] : null;
    String? parsedLongitude =
        json.containsKey('longitude') ? json['longitude'] : null;
    double? parsedDistance =
        json.containsKey('distance') ? checkDouble(json['distance']) : null;

    int? generations = json.containsKey('generations_identity_id')
        ? json['generations_identity_id']
        : null;
    List earningsStr = json.containsKey('who_earns') ? json['who_earns'] : [];
    Set<Earning> earnings = earningsStr.map((e) => Earning.fromJson(e)).toSet();
    List interestsStr =
        json.containsKey('what_you_likes') ? json['what_you_likes'] : [];
    Set<Interest> interests =
        interestsStr.map((e) => Interest.fromJson(e)).toSet();

    if (parsedUserId == null ||
        parsedUserName == null ||
        parsedGenderId == null ||
        parsedLatitude == null ||
        parsedLongitude == null ||
        parsedPhone == null ||
        parsedDistance == null ||
        generations == null)
      throw ParseException(message: "Incorrect data structure");

    Gender? gender = Gender.fromId(parsedGenderId);
    if (gender == null)
      throw ParseException(message: "Incorrect data structure");

    return Profile(
      userId: parsedUserId,
      userName: parsedUserName,
      userPhone: parsedPhone,
      profilePhoto: parsedProfilePhoto ?? "",
      wantToMeet: parsedWantToMeet,
      isLgbt: parsedIsLgbt,
      gender: gender,
      facebook: parsedFacebook,
      instagram: parsedInstagram,
      linkedin: parsedLinkedin,
      interests: interests,
      earnings: earnings,
      generationId: generations,
      longitude: double.parse(parsedLongitude),
      latitude: double.parse(parsedLatitude),
      range: parsedDistance,
    );
  }
}
