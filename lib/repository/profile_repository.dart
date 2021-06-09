import 'dart:io';

import 'package:simposi_app_v4/model/errors.dart';
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

  Future<String?> changePassword(String password) async {
    NetworkResponse response =
    await _apiService.post(ApiService.API_CHANGE_PASSWORD,
        data: {
          'password': password,
        },
        auth: true);
    if (response is NetworkResponseError) {
      throw ApiException(
          errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      String? message = response.message;
      return message;
    }
  }
}
