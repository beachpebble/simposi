// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';

class Api {
  static const String apiPath =
      "https://phplaravel-742854-2530276.cloudwaysapps.com";

  static const String apiLogin = "/api/v1/login";
  static const String apiChangePassword = "/api/v1/forgot-password";
  static const String apiAcceptCode = "/api/v1/verification/sms-code";
  static const String apiUploadAvatar = "/api/v1/upload-profile-photo";
  static const String apiMasterData = "/api/v1/dictionaries";
  static const String apiRegister = "/api/v1/register";
  static const String apiUserExists = "/api/v1/verification/check-phone";
  static const String apiUserEdit = "/api/v1/user/update-profile";
  static const String apiRSVPStatus = "/api/v1/rsvps/status/change";
  static const String apiRefreshLocator = "/api/v1/refreshlocator";
  static const String apiCheckIn = "/api/v1/events/check-in";
  static const String apiGroupFinder = "/api/v1/events/group-finder";
  static const String apiProfile = "/api/v1/user/profile";
  static const String apiEvent = "/api/v1/events";
  static const String apiEventCancel = "/api/v1/events/cancel";
  static const String apiGetSurveyRequests = "/api/v1/survey";
  static const String apiSendSurvey = "/api/v1/survey";
  static const String apiUpdateFacebookToken = "/api/v1/update-device-token";

  static const String apiRsvpList = "/api/v1/rsvps/info";
}

class ApiService {
  final String baseUrl;
  late Dio _dio;
  late CookieJar _cookieJar;

  ApiService({this.baseUrl = Api.apiPath}) {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.followRedirects = false;
    _dio.options.headers = {'accept': 'application/json'};
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

  Dio get dio => _dio;
}

class AuthApiService {
  final String baseUrl;
  late Dio _dio;
  late CookieJar _cookieJar;
  final AuthenticationBloc _authenticationBloc;

  AuthApiService({
    required AuthenticationBloc authenticationBloc,
    this.baseUrl = Api.apiPath,
  }) : _authenticationBloc = authenticationBloc {
    _authenticationBloc.stream.listen((state) {
      if (state is Authenticated) {
        _dio.options.headers = {
          'accept': 'application/json',
          'Authorization': 'Bearer ${_authenticationBloc.token}'
        };
      }
    });
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.followRedirects = false;
    _dio.options.headers = {'accept': 'application/json'};
    _dio.options.headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_authenticationBloc.token}'
    };
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
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
        _authenticationBloc.add(Auth401());
      }
      return handler.next(e); //continue
    }));
  }

  Dio get dio => _dio;
}
