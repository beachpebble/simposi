import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/model/profile.dart';

import 'api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  late Profile profile;
  final LocalStorage storage = new LocalStorage('profile_storage');

  Future<void> setProfile(Map data) async {
    await storage.setItem("profile", data);
    profile = Profile.fromJson(data);
  }

  Future<void> refreshProfile() async {
    var data = await storage.getItem("profile");
    profile = Profile.fromJson(data);
  }

  Future<Map> login(String login, String password) async {
    Map<String, Object> params = {
      'phone': login,
      'password': password,
    };
    //TODO take this value from FCM
    params["device_token"] = "1234567";
    params["device_type"] = Platform.isAndroid ? 1 : 2;
    Response response = await (await _apiService.post(ApiService.API_LOGIN,
        data: params, auth: false));
    return response.data;
  }

  Future changePassword(String password, String token) async {
    await _apiService.post(ApiService.API_CHANGE_PASSWORD,
        data: {
          'password': password,
        },
        auth: false,
        customToken: token);
  }

  Future<String?> acceptCode(String phone, String code) async {
    Response response = await _apiService.post(ApiService.API_ACCEPT_CODE,
        data: {
          'code': code,
          'phone': phone,
        },
        auth: false);
    String? token = response.data["apiAccessToken"];
    return token;
  }

  Future<String?> uploadAvatar(String path) async {
    String fileName = path.split('/').last;
    FormData formData = FormData.fromMap({
      "Image": await MultipartFile.fromFile(
        path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    Response response = await _apiService.postMulti(
        ApiService.API_UPLOAD_AVATAR,
        data: formData,
        lang: false,
        auth: false);
    var messages = response.data;
    if (messages is List && messages.isNotEmpty) {
      return messages.first;
    } else {
      throw ApiException(
          errorType: LocalizedErrorType.OTHER, message: "Unexpected response");
    }
  }

  //TODO make a local cache for this data
  Future<MasterData> getMasterData() async {
    Response response =
        await _apiService.get(ApiService.API_MASTER_DATA, auth: false);
    Map? data = response.data['data'];
    List<Interest> interestList = [];
    if (data != null &&
        data.containsKey('whatYouLike') &&
        data['whatYouLike'] is List) {
      List il = data['whatYouLike'];
      interestList = (il.map((e) => Interest.fromJson(e)).toList());
    }
    List<Generation> generationList = [];
    if (data != null &&
        data.containsKey('generationsIdentity') &&
        data['generationsIdentity'] is List) {
      List il = data['generationsIdentity'];
      generationList = (il.map((e) => Generation.fromJson(e)).toList());
    }
    List<Earning> earninigList = [];
    if (data != null &&
        data.containsKey('whoEarn') &&
        data['whoEarn'] is List) {
      List il = data['whoEarn'];
      earninigList = (il.map((e) => Earning.fromJson(e)).toList());
      earninigList.sort((first, second) {
        return first.sortId.compareTo(second.sortId);
      });
    }
    return MasterData({}..addAll(interestList), generationList, earninigList);
  }

  // Returns 200 if user doesnt exist
  Future userNotExist({
    required String phone,
  }) async {
    Map<String, Object> data = {
      "phone": phone,
    };
    Response response = await _apiService.post(ApiService.API_USER_EXISTS,
        auth: false, data: data);
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
    var data = {
      "name": name,
      //"profile_photo": image,
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
    Response response = await _apiService.post(ApiService.API_REGISTER,
        auth: false, data: data);
    return response.data;
  }

  Future requestConfirmationCode(String phone) async {
    await _apiService.get(ApiService.API_ACCEPT_CODE,
        queryParameters: {"phone": phone}, auth: false);
  }

  Future updateProfile({
    String? name,
    String? phone,
    String? filepath,
    String? facebook,
    String? instagram,
    String? linkedin,
  }) async {
    Map<String, Object> data = {};
    if (name != null) data["user_name"] = name;
    if (filepath != null) data["profile_photo"] = filepath;
    if (facebook != null && facebook.isNotEmpty)
      data["facebook_url"] = facebook;
    if (instagram != null && instagram.isNotEmpty)
      data["instagram__url"] = instagram;
    if (linkedin != null && linkedin.isNotEmpty)
      data["linkedin__url"] = linkedin;
    if (phone != null && phone.isNotEmpty) data["phone"] = phone;
    return updateProfileFields(data);
  }

  Future updateProfileGender(
      {required Gender gender, required bool lgbt}) async {
    Map<String, Object> data = {
      "Gender": gender.id,
      "IsLGBTQ": lgbt,
    };
    return updateProfileFields(data);
  }

  Future updateProfileGenerations({required int generation}) async {
    Map<String, Object> data = {"generation": generation};
    return updateProfileFields(data);
  }

  Future updateProfileInterests({required List<int> interests}) async {
    Map<String, Object> data = {"what_you_like": interests};
    return updateProfileFields(data);
  }

  Future updateProfileLocation(
      {required double latitude,
      required double longitude,
      required double range}) async {
    Map<String, Object> data = {
      "longitude": longitude,
      "latitude": latitude,
      "distance": range,
    };
    return updateProfileFields(data);
  }

  Future updateProfileIncome({required List<int> earnings}) async {
    Map<String, Object> data = {"whoEarn": earnings};
    return updateProfileFields(data);
  }

  Future updateProfileFields(Map<String, Object> data) async {
    Response response = await _apiService.put(
      ApiService.API_USER_EDIT,
      data: data,
      auth: true,
    );
    await setProfile(response.data);
  }
}
