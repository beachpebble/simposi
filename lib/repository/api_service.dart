import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/network_response.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'auth_repository.dart';

class ApiService {
  final AuthRepository authRepository;
  final baseUrl;
  late Dio _dio;
  late CookieJar _cookieJar;

  static const String TEST = "https://simposi-dev.uastar.space";

  static const String API_LOGIN = "/api/v1/login";
  static const String API_CHANGE_PASSWORD = "/api/v1/forgot-password";
  static const String API_ACCEPT_CODE = "/api/v1/verification/sms-code";
  static const String API_UPLOAD_AVATAR = "/api/v1/upload-profile-photo";
  static const String API_MASTER_DATA = "/api/v1/dictionaries";
  static const String API_REGISTER = "/api/v1/register";
  static const String API_USER_EXISTS = "/api/v1/verification/check-phone";
  static const String API_USER_EDIT = "/api/v1/user/update-profile";

  static const String API_NEW_EVENT = "/api/v1/event";
  static const String RSVP_LIST = "/api/v1/rsvp";

  ApiService({required this.authRepository, this.baseUrl = TEST}) {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.options.contentType = Headers.jsonContentType;
    _cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 200));
  }

  Future<Response<Map>> post(String path, {
    required Map<String, Object> data,
    auth: true,
    String? customToken,
    bool lang = true
  }) async {
    var options = await _prepareRequest(path, auth);
    if (customToken != null && auth == false)
      options.headers!['Authorization'] = "Bearer $customToken";
    String s = json.encode(data);
    print("WTF $s");
    Response<Map> response = await _dio.post(path, data: data, options: options);
    return response;
  }

  Future<Response> put(String path, {
    required Map<String, Object> data,
    auth: true,
    String? customToken,
    bool lang = true
  }) async {
    var options = await _prepareRequest(path, auth);
    if (customToken != null && auth == false)
      options.headers!['Authorization'] = "Bearer $customToken";
    //TODO later change to locale set on device
    final response = await _dio.put(path, data: data, options: options);
    return response;
  }

  Future<Response> postMulti(String path, {
    required dynamic data,
    auth: true,
    bool lang = true
  }) async {
    var options = await _prepareRequest(path, auth);
    final response = await _dio.post(path, data: data, options: options);
    return response;
  }

  Future<Response<Map>> get(
      String path, {
        auth: true,
        String? customToken,
        Map<String, dynamic>? queryParameters,
      }) async {
    var options = await _prepareRequest(path, auth);
    if (customToken != null && auth == false)
      options.headers!['Authorization'] = "Bearer $customToken";
    Response<Map> response = await _dio.get(path, options: options, queryParameters: queryParameters);
    return response;
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

  // NetworkResponse _handleResponse(Response response, String method, String host) {
  //   if (response.statusCode != 200) {
  //     throw ServerException(
  //         errorType: LocalizedErrorType.SERVER_ERROR,
  //         message: 'Fail $method $host Error: ${response.statusCode}');
  //   }
  //   var body;
  //   try {
  //     if (response.data is String)
  //       body = jsonDecode(response.data);
  //     else
  //       body = response.data;
  //     if (body is Map && body.containsKey("status")) {
  //       if (body['status'] == 200 || body['status'] == 201) {
  //         NetworkResponseSuccess networkResponseSuccess =
  //         NetworkResponseSuccess.fromJson(body);
  //         return networkResponseSuccess;
  //       } else {
  //         NetworkResponseError networkResponseError =
  //         NetworkResponseError.fromJson(body);
  //         return networkResponseError;
  //       }
  //     } else {
  //       throw ParseException(message: 'Invalid server response type');
  //     }
  //   } catch (e) {
  //     throw ParseException(message: 'Invalid server response');
  //   }
  // }
}
