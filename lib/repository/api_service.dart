import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/network_response.dart';
import 'dart:developer' as developer;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'auth_repository.dart';

class ApiService {
  final AuthRepository authRepository;
  final baseUrl;
  late Dio _dio;
  late CookieJar _cookieJar;

  static const String TEST = "https://simposi.uastar.space";

  static const String API_LOGIN = "/api/v1/user/login";
  static const String API_FORGOT_PASSWORD_START = "/api/v1/user/forgotPassword";
  static const String API_FORGOT_PASSWORD_COMPLETE = "/api/v1/user/changeForgotPassword";
  static const String API_CHANGE_PASSWORD = "/api/v1/user/changeForgotPassword2";

  ApiService({required this.authRepository, this.baseUrl = TEST}) {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.options.contentType = Headers.jsonContentType;
    _cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  Future<NetworkResponse> post(String path, {
    required Map data,
    auth: true,
  }) async {
    var options = await _prepareRequest(path, auth);
    developer.log(
        'cookies ${_cookieJar.loadForRequest(
            Uri.parse(_dio.options.baseUrl + path))}');
    developer.log('_post $path options: ${options.headers}   data: $data');
    //TODO later change to locale set on device
    data["language_id"] = 1;
    final response = await _dio.post(path, data: data, options: options);

    return _handleResponse(response, 'POST', path);
  }

  Future<Options> _prepareRequest(String path, bool withAuth) async {
    Map<String, String> headers = {};
    if (withAuth) {
      if (authRepository.jwt == null) {
        await authRepository.logout();
      }
      if (authRepository.jwt == null) {
        throw AuthException(
            message: 'Unable to send request jwt is not defined');
      }
      headers['Authorization'] = "Bearer ${authRepository.jwt}";
    }
    return Options(
        headers: headers,
        responseType: ResponseType.json);
  }

  NetworkResponse _handleResponse(Response response, String method, String host) {
    if (response.statusCode != 200) {
      throw ServerException(
          errorType: LocalizedErrorType.SERVER_ERROR,
          message: 'Fail $method $host Error: ${response.statusCode}');
    }
    var body;
    developer.log('_handle response ');
    try {
      body = jsonDecode(response.data);
      developer.log('_handle response $body');
      if (body is Map && body.containsKey("status")) {
        developer.log('response is map (ok or redirect)');
        if (body['status'] == 200 || body['status'] == 201) {
          NetworkResponseSuccess networkResponseSuccess =
          NetworkResponseSuccess.fromJson(body);
          return networkResponseSuccess;
        } else {
          NetworkResponseError networkResponseError =
          NetworkResponseError.fromJson(body);
          return networkResponseError;
        }
      } else {
        throw ParseException(message: 'Invalid server response type');
      }
    } catch (e) {
      throw ParseException(message: 'Invalid server response');
    }
  }
}
