import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';

import 'auth_repository.dart';

class ApiService {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;
  final baseUrl;
  late Dio _dio;
  late CookieJar _cookieJar;

  static const  String PROD = "https://url.com";

  ApiService({required this.authRepository, required this.authenticationBloc, this.baseUrl = PROD});
}