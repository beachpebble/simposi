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
import 'package:simposi_app_v4/model/network_response.dart';
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
    var data  = await storage.getItem("profile");
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
    NetworkResponse response = await (await _apiService
        .post(ApiService.API_LOGIN, data: params, auth: false));
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      return response.data;
    } else {
      throw ApiException(errorType: LocalizedErrorType.UNEXPECTED);
    }
  }

  Future<String?> changePassword(String password, String token) async {
    NetworkResponse response =
        await _apiService.post(ApiService.API_CHANGE_PASSWORD,
            data: {
              'password': password,
            },
            auth: false,
            customToken: token);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      return message;
    }
  }

  Future<String?> acceptCode(String phone, String code) async {
    NetworkResponse response =
        await _apiService.post(ApiService.API_ACCEPT_CODE,
            data: {
              'code': code,
              'phone': phone,
            },
            auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? token = response.data["apiAccessToken"];
      return token;
    }
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
    NetworkResponse response = await _apiService.postMulti(
        ApiService.API_UPLOAD_AVATAR,
        data: formData,
        lang: false,
        auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      var messages = response.data;
      if (messages is List && messages.isNotEmpty) {
        return messages.first;
      } else {
        throw ApiException(
            errorType: LocalizedErrorType.OTHER,
            message: "Unexpected response");
      }
    }
  }

  //TODO make a local cache for this data
  Future<MasterData> getMasterData() async {
    NetworkResponse response =
        await _apiService.get(ApiService.API_MASTER_DATA, auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: response.message);
    } else if (response is NetworkResponseSuccess) {
      Map? data = response.data;
      List<Interest> interestList = [];
      if (data != null &&
          data.containsKey('interest') &&
          data['interest'] is List) {
        List il = data['interest'];
        interestList = (il.map((e) => Interest.fromJson(e)).toList());
      }
      List<Generation> generationList = [];
      if (data != null &&
          data.containsKey('generationIdentify') &&
          data['generationIdentify'] is List) {
        List il = data['generationIdentify'];
        generationList = (il.map((e) => Generation.fromJson(e)).toList());
      }
      List<Earning> earninigList = [];
      if (data != null &&
          data.containsKey('whoEarn') &&
          data['whoEarn'] is List) {
        List il = data['whoEarn'];
        earninigList = (il.map((e) => Earning.fromJson(e)).toList());
        earninigList.sort((first, second){ return first.sortId.compareTo(second.sortId);});
      }
      return MasterData({}..addAll(interestList), generationList, earninigList);
    } else {
      throw ApiException(
        errorType: LocalizedErrorType.SERVER_ERROR,
      );
    }
  }

  // Returns 200 if user doesnt exist
  Future userNotExist({
    required String phone,
  }) async {
    Map<String, Object> data = {
      "phone": phone,
    };
    NetworkResponse response = await _apiService
        .post(ApiService.API_USER_EXISTS, auth: false, data: data);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: response.message);
    } else if (response is NetworkResponseSuccess) {
      return;
    } else {
      throw ApiException(
        errorType: LocalizedErrorType.SERVER_ERROR,
      );
    }
  }

  Future<Map> sendRegistration({
    required String name,
    required String image,
    required String phone,
    required String password,
    required String latitude,
    required String longitude,
    required double distance,
    required String gender,
    required String wantToMeet,
    required bool isLgbt,
    required List<int> generation,
    required List<int> earning,
    required List<int> likes,
  }) async {
    var data = {
      "Name": name,
      "Image": image,
      "Phone": phone,
      "Password": password,
      "Latitude": latitude,
      "Longitude": longitude,
      "Distance": distance,
      "Gender": gender,
      "Meet": wantToMeet,
      "IsLGBTQ": isLgbt,
      "Generation": generation,
      "Earning": earning,
      "likes": likes,
      "City": "Dnipro",
    };
    data["device_token"] = "1234567";
    data["device_type"] = Platform.isAndroid ? 1 : 2;
    NetworkResponse response = await _apiService.post(ApiService.API_REGISTER,
        auth: false, data: data);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: response.message);
    } else if (response is NetworkResponseSuccess) {
      return response.data;
    } else {
      throw ApiException(
        errorType: LocalizedErrorType.SERVER_ERROR,
      );
    }
  }

  Future<String> sendConfirmationCode(String phone) async {
    NetworkResponse response = await _apiService.get(ApiService.API_SEND_CODE,
        queryParameters: {"phone": phone}, auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      return message ?? "";
    } else {
      throw ApiException(
        errorType: LocalizedErrorType.SERVER_ERROR,
      );
    }
  }

  Future<String?> updateProfile(
      {String? name,
      String? filepath,
      String? facebook,
      String? instagram,
      String? linkedin}) async {
    Map<String, Object> data = {};
    if (name != null)
      data["user_name"] = name;
    if (filepath != null)
      data["profile_photo"] = filepath;
    if (facebook != null && facebook.isNotEmpty)
      data["facebook_url"] = facebook;
    if (instagram != null && instagram.isNotEmpty)
      data["instagram__url"] = instagram;
    if (linkedin != null && linkedin.isNotEmpty)
      data["linkedin__url"] = linkedin;
    return updateProfileFields(data);
  }

  Future<String?> updateProfileGender(
      {required Gender gender,
        required bool lgbt}) async {
    Map<String, Object> data = {
      "Gender": gender.id,
      "IsLGBTQ": lgbt,
    };
    return updateProfileFields(data);
  }

  Future<String?> updateProfileFields(
      Map<String, Object> data) async {
    NetworkResponse response =
    await _apiService.put(ApiService.API_USER_EDIT,
      data: data,
      auth: true,
    );
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      await setProfile(response.data);
      return message;
    }
  }


}
