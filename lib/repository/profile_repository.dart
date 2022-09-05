import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/emergency_contact.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/profile.dart';
import 'package:simposi_app_v4/model/profile_status.dart';
import 'package:simposi_app_v4/model/user_meta.dart';

import 'api_service.dart';

class ProfileRepository {
  final AuthApiService _authApiService;
  final ApiService _apiService;

  ProfileRepository(this._apiService, this._authApiService);

  late Profile profile;
  final LocalStorage storage = LocalStorage('profile_storage');

  Future<void> setProfile(Map<String, dynamic> data) async {
    await storage.ready;
    await storage.setItem("profile", data);

    profile = Profile.fromJson(data);
  }

  Future<Profile> refreshProfile() async {
    await storage.ready;
    final data = await storage.getItem("profile");
    profile = Profile.fromJson(data);
    return profile;
  }

  Future updateFbToken(String newToken) async {
    await storage.ready;
    final String? oldFbToken = await storage.getItem("fbToken");
    if (oldFbToken != null && oldFbToken == newToken) {
      print("Fb token was not changed");
    } else {
      print("Fb token was changed. Set new one. ");
      await _authApiService.dio.post(Api.API_UPDATE_FB_TOKEN, data: {
        'device_token': newToken,
      });
      await storage.setItem("fbToken", newToken);
    }
  }

  Future<ProfileStatus> refreshStatus() async {
    final response = await _authApiService.dio.get(Api.API_PROFILE);
    final Map data = response.data;

    if (data["data"] != null) {
      final profileStatus = ProfileStatus.fromJson(data["data"]);
      return profileStatus;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<Map> login(String login, String password) async {
    await storage.ready;
    final String? fbToken = await storage.getItem("fbToken");
    final params = <String, Object>{
      'phone': login,
      'password': password,
    };
    if (fbToken != null && fbToken.isNotEmpty) params["device_token"] = fbToken;
    final response = (await _apiService.dio.post(Api.API_LOGIN, data: params));
    return response.data;
  }

  Future changePassword(String password, String token) async {
    await _authApiService.dio.post(Api.API_CHANGE_PASSWORD, data: {
      'password': password,
    });
  }

  Future<String?> acceptCode(String phone, String code) async {
    final response = await _apiService.dio.post(Api.API_ACCEPT_CODE, data: {
      'code': code,
      'phone': phone,
    });
    final Map data = response.data;

    if (data["data"]?["token"] != null) {
      final String token = data["data"]?["token"];
      return token;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<String?> uploadProfilePhoto(String path) async {
    final fileName = path.split('/').last;
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    final response =
        await _apiService.dio.post(Api.API_UPLOAD_AVATAR, data: formData);
    final Map? data = response.data;
    final String? name = data?["data"]?['name'];
    if (name != null) {
      return name;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  // Returns 200 if user doesnt exist
  Future<bool> userNotExist({
    required String phone,
  }) async {
    final data = <String, Object>{
      "phone": phone,
    };
    final response =
        await _apiService.dio.post(Api.API_USER_EXISTS, data: data);
    final bool? isPhoneUsed = response.data?['data']?['isPhoneUsed'];
    if (isPhoneUsed == null) {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    } else {
      return isPhoneUsed;
    }
  }

  Future<Map> sendRegistration({
    required String name,
    required String image,
    required String phone,
    required String password,
    required String latitude,
    required String longitude,
    required String distance,
    required String gender,
    required bool isLgbt,
    required int generation,
    required List<int> earning,
    required List<int> likes,
  }) async {
    final data = {
      "name": name,
      "profile_photo": image,
      "phone": phone,
      "password": password,
      "password_confirmation": password,
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
      "gender": gender,
      "is_lgbtq": isLgbt,
      "generation": generation,
      "who_earns": earning,
      "what_you_likes": likes,
    };
    final response = await _apiService.dio.post(Api.API_REGISTER, data: data);
    return response.data;
  }

  Future requestConfirmationCode(String phone) async {
    await _apiService.dio.get("${Api.API_ACCEPT_CODE}/$phone");
  }

  Future<Profile> updateProfile({
    String? name,
    String? phone,
    String? filepath,
    String? facebook,
    String? instagram,
    String? linkedin,
  }) async {
    final data = <String, Object>{};
    if (name != null) data["name"] = name;
    if (filepath != null) data["profile_photo"] = filepath;
    if (facebook != null && facebook.isNotEmpty) {
      data["facebook_url"] = facebook;
    }
    if (instagram != null && instagram.isNotEmpty) {
      data["instagram"] = instagram;
    }
    if (linkedin != null && linkedin.isNotEmpty) {
      data["linkedin_url"] = linkedin;
    }
    if (phone != null && phone.isNotEmpty) data["phone"] = phone;
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileGender(
      {required Gender gender, required bool lgbt}) async {
    final data = <String, Object>{
      "gender": gender.id,
      "is_lgbtq": lgbt,
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateEmergencyContact(
      {required EmergencyContact contact}) async {
    final data = <String, Object>{
      "emergency_contact_name": contact.name,
      "emergency_contact_phone": contact.phone,
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileGenerations({required int generation}) async {
    final data = <String, Object>{"generations_identity_id": generation};
    return updateProfileFields(data);
  }

  Future<Profile> updateWantToMeetGenerations(
      {required List<Generation> generations}) async {
    UserMeta meta;
    if (profile.userMeta == null) {
      meta = UserMeta(
          wantToMeetGender: const [],
          wantToMeetGenerations: generations,
          wantToMeetEarnings: const [],
          wantToMeetLgbt: false,
          wantToMeetInterests: const []);
    } else {
      meta = profile.userMeta!.copy(wantToMeetGenerations: generations);
    }
    final data = <String, Object>{
      "meta_data": meta.toJson(),
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileInterests({required List<int> interests}) async {
    final data = <String, Object>{"what_you_likes": interests};
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileLocation(
      {required double latitude,
      required double longitude,
      required double range}) async {
    final data = <String, Object>{
      "longitude": longitude,
      "latitude": latitude,
      "distance": range,
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileIncome({required List<int> earnings}) async {
    final data = <String, Object>{"who_earns": earnings};
    return updateProfileFields(data);
  }

  Future<Profile> updateWantToMeetIncome(
      {required List<Earning> earnings}) async {
    UserMeta meta;
    if (profile.userMeta == null) {
      meta = UserMeta(
          wantToMeetGender: const [],
          wantToMeetGenerations: const [],
          wantToMeetEarnings: earnings,
          wantToMeetLgbt: false,
          wantToMeetInterests: const []);
    } else {
      meta = profile.userMeta!.copy(wantToMeetEarnings: earnings);
    }
    final data = <String, Object>{
      "meta_data": meta.toJson(),
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateWantToMeetGender(
      {required List<Gender> gender, required bool lgbt}) async {
    UserMeta meta;
    if (profile.userMeta == null) {
      meta = UserMeta(
          wantToMeetGender: gender,
          wantToMeetGenerations: const [],
          wantToMeetEarnings: const [],
          wantToMeetLgbt: false,
          wantToMeetInterests: const []);
    } else {
      meta = profile.userMeta!.copy(wantToMeetGender: gender, lgbt: lgbt);
    }
    final data = <String, Object>{
      "meta_data": meta.toJson(),
    };
    return updateProfileFields(data);
  }

  Future<Profile> updateProfileFields(Map<String, Object> data) async {
    final response =
        await _authApiService.dio.put(Api.API_USER_EDIT, data: data);
    final Map<String, dynamic>? user = response.data["data"]?["user"];
    if (user != null) {
      await setProfile(user);
      return Profile.fromJson(user);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }
}
