import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/model/network_response.dart';

import 'api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

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
      throw ApiException(
          errorType: LocalizedErrorType.UNEXPECTED);
    }
  }

  Future<String?> forgotPasswordRequest(String phone) async {
    Map<String, Object> params = {
      'phone': phone,
    };
    NetworkResponse response =
        await _apiService.post(ApiService.API_FORGOT_PASSWORD_START,
            data: params,
            auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      return message;
    }
  }

  Future<String?> forgotPasswordComplete(String password, String hash) async {
    NetworkResponse response =
        await _apiService.post(ApiService.API_FORGOT_PASSWORD_COMPLETE,
            data: {
              'password': password,
              'token': hash,
            },
            auth: false);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      return message;
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
      }
      return MasterData(interestList, generationList, earninigList);
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

  Future<String> validateCode(String code, String token) async {
    NetworkResponse response = await _apiService
        .get(ApiService.API_VALIDATE + code, auth: false, customToken: token);
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
}
