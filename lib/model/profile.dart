import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/gender.dart';

import 'errors.dart';

class Profile extends Equatable {
  final int userId;
  final int userRoleId;
  final String userName;
  final String profilePhoto;
  final String wantToMeet;
  final bool isLgbt;
  final Gender gender;

  Profile(
      {required this.userId,
      required this.userRoleId,
      required this.userName,
      required this.profilePhoto,
      required this.isLgbt,
      required this.gender,
      required this.wantToMeet});

  @override
  List<Object?> get props =>
      [userId, userRoleId, userName, profilePhoto, wantToMeet];

  static Profile fromJson(Map json) {
    int? parsedUserId = json.containsKey('user_id') ? json['user_id'] : null;
    int? parsedUserRoleId =
        json.containsKey('user_role_id') ? json['user_role_id'] : null;
    String? parsedUserName =
        json.containsKey('user_name') ? json['user_name'] : null;
    String? parsedProfilePhoto =
        json.containsKey('profile_photo') ? json['profile_photo'] : null;
    String? parsedWantToMeet =
        json.containsKey('meet') ? json['meet'] : null;
    String? parsedGenderId =
        json.containsKey('gender') ? json['gender'] : null;

    bool parsedIsLgbt =
        json.containsKey('islgbtq') ? json['islgbtq'] > 0 : false;

    if (parsedUserId == null ||
        parsedUserRoleId == null ||
        parsedUserName == null ||
        parsedWantToMeet == null ||
        parsedGenderId == null ||
        parsedProfilePhoto == null)
      throw ParseException(message: "Incorrect data structure");

    Gender? gender = Gender.fromId(parsedGenderId);

    if (gender == null)
      throw ParseException(message: "Incorrect data structure");

    return Profile(
        userId: parsedUserId,
        userName: parsedUserName,
        profilePhoto: parsedProfilePhoto,
        wantToMeet: parsedWantToMeet,
        isLgbt: parsedIsLgbt,
        gender: gender,
        userRoleId: parsedUserRoleId);
  }
}
