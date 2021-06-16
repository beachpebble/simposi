import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/model/network_response.dart';

import 'api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future login(String login, String password) async {
    Map params = {
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
      Map data = response.data;
      if (data.containsKey('apiAccessToken') &&
          data['apiAccessToken'] != null) {
        await _apiService.authRepository.saveAuth(data['apiAccessToken']);
        return;
      } else {
        throw AuthException(
            message: "Login successful but does not contain token");
      }
    }
  }

  Future<String?> forgotPasswordRequest(String phone) async {
    NetworkResponse response =
        await _apiService.post(ApiService.API_FORGOT_PASSWORD_START,
            data: {
              'phone': phone,
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
    NetworkResponse response = await _apiService.post(
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
      if (data != null && data.containsKey('interest') && data['interest'] is List) {
        List il = data['interest'];
        interestList =
        (il.map((e) => Interest.fromJson(e)).toList());
      }
      return MasterData(interestList);
    } else {
      throw ApiException(
          errorType: LocalizedErrorType.SERVER_ERROR,);
    }
  }
}
