import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/utils/type_utils.dart';

import 'errors.dart';

class Profile extends Equatable {
  final int userId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String profilePhoto;
  final String? wantToMeet;
  final bool isLgbt;
  final Gender gender;
  final Set<Generation> generations;
  final Set<Earning> earnings;
  final Set<Interest> interests;
  final double latitude;
  final double longitude;
  final double range;

  Profile({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.profilePhoto,
    required this.isLgbt,
    required this.gender,
    required this.wantToMeet,
    required this.generations,
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
        userEmail,
        profilePhoto,
        wantToMeet,
    generations, earnings, interests, latitude, longitude, range
      ];

  static Profile fromJson(Map json) {
    developer.log("Profile loading from json $json");
    int? parsedUserId = json.containsKey('user_id') ? json['user_id'] : null;
    String? parsedUserName =
        json.containsKey('user_name') ? json['user_name'] : null;
    String? parsedProfilePhoto =
        json.containsKey('profile_photo') ? json['profile_photo'] : null;
    String? parsedWantToMeet = json.containsKey('meet') ? json['meet'] : null;
    String? parsedGenderId = json.containsKey('gender') ? json['gender'] : null;
    bool parsedIsLgbt = json.containsKey('islgbtq') && json['islgbtq'] != null
        ? json['islgbtq'] > 0
        : false;
    String? parsedFacebook =
        json.containsKey('facebook_url') ? json['facebook_url'] : null;
    String? parsedInstagram =
        json.containsKey('instagram__url') ? json['instagram__url'] : null;
    String? parsedLinkedin =
        json.containsKey('linkedln__url') ? json['linkedln__url'] : null;

    String? parsedPhone = json.containsKey('phone') ? json['phone'] : null;

    String? parsedLatitude = json.containsKey('latitude') ? json['latitude'] : null;
    String? parsedLongitude = json.containsKey('longitude') ? json['longitude'] : null;
    double? parsedDistance = json.containsKey('distance') ? checkDouble(json['distance']) : null;

    if (parsedUserId == null ||
        parsedUserName == null ||
        parsedGenderId == null ||
        parsedLatitude == null ||
        parsedLongitude == null ||
        parsedPhone == null ||
        parsedDistance == null
    )
      throw ParseException(message: "Incorrect data structure");

    Gender? gender = Gender.fromId(parsedGenderId);
    if (gender == null)
      throw ParseException(message: "Incorrect data structure");

    List generationsStr =
        json.containsKey('generations') ? json['generations'] : [];
    Set<Generation> generations =
        generationsStr.map((e) => Generation.fromJson(e)).toSet();
    List earningsStr = json.containsKey('whoEarn') ? json['whoEarn'] : [];
    Set<Earning> earnings = earningsStr.map((e) => Earning.fromJson(e)).toSet();
    List interestsStr =
        json.containsKey('what_you_like') ? json['what_you_like'] : [];
    Set<Interest> interests =
        interestsStr.map((e) => Interest.fromJson(e)).toSet();

    return Profile(
      userId: parsedUserId,
      userName: parsedUserName,
      userPhone: parsedPhone,
      userEmail: "",
      profilePhoto: parsedProfilePhoto ?? "",
      wantToMeet: parsedWantToMeet,
      isLgbt: parsedIsLgbt,
      gender: gender,
      facebook: parsedFacebook,
      instagram: parsedInstagram,
      linkedin: parsedLinkedin,
      interests: interests,
      earnings: earnings,
      generations: generations,
      longitude: double.parse(parsedLongitude),
      latitude:double.parse(parsedLatitude),
      range: parsedDistance,
    );
  }
}
