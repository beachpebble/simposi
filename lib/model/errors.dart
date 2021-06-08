import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum LocalizedErrorType {
  PARSE_JWT_ERROR,
  PARSE_ERROR,
  AUTH,
  SERVER_ERROR,
  DIO_TIMEOUT,
  DIO_DEFAULT,
  NETWORK,
  OTHER
}

/**
    Exceptions from parsing routines, mostly when some expected  mandatory fields
    are not set, so data consistency is broken or business logic required data
    missing
 */
class ParseException implements Exception {
  final String message;
  final LocalizedErrorType errorType;

  ParseException(
      {this.errorType = LocalizedErrorType.PARSE_ERROR, this.message = ""});

  @override
  String toString() {
    if (message.isNotEmpty)
      return message;
    else
      return "Parse exception";
  }
}

/**
    Errors from API layer, like serverside status errors like missing parameters,
    or some server exceptions, so everything when response from server is received
    but contains status with error code
    !!! Not errors from network layers when http ststus code is not 200/201
    see @ServerException
 */
class ApiException implements Exception {
  final String message;
  final LocalizedErrorType errorType;

  ApiException({required this.errorType, this.message = ""});

  @override
  String toString() {
    if (message.isNotEmpty)
      return message;
    else
      return "Unknown API exception";
  }
}

/**
    Errors from network layer in cases when http code is not 200*
 */
class ServerException implements Exception {
  final int code;
  final String message;
  final LocalizedErrorType errorType;

  ServerException({required this.errorType, this.message = "", this.code = 0});

  @override
  String toString() {
    if (message.isNotEmpty)
      return message;
    else
      return "Unknown ServerException";
  }
}

class AuthException extends ApiException {
  AuthException({String message = ""})
      : super(errorType: LocalizedErrorType.AUTH, message: message);
}

//TODO LOcalize
String handleError(dynamic exception, BuildContext context) {
  if (exception is AuthException) {
      return "Auth error ${exception.message}";
  } else if (exception is ApiException) {
    return "Api error ${exception.message}";
  } else if (exception is DioError) {
    return getDioException(exception, context);
  } else if (exception is ParseException) {
    return "Data parse error";
  } else {
    return "Unknown error";
  }
}

//TODO LOcalize
String getDioException(DioError dioError, BuildContext context) {
  switch (dioError.type) {
    case DioErrorType.response:
      return _getDioResponseError(dioError);
      case DioErrorType.cancel:
      return "Request cancelled";
    case DioErrorType.connectTimeout:
      return "Connection timeout";
    case DioErrorType.receiveTimeout:
      return "receive timeout";
    case DioErrorType.sendTimeout:
      return "Send timeout timeout";
    case DioErrorType.other:
      dynamic error = dioError.error;
      if (error is SocketException)
        return "Network error";
      else
        return dioError.message.isEmpty == true ? "Unknown Dio error" : dioError.message;
    default:
      return dioError.message.isEmpty == true ? "Unknown Dio error" : dioError.message;
  }
}

String _getDioResponseError(DioError dioError) {
  if (dioError.type == DioErrorType.response && dioError.response != null) {
    Response response = dioError.response!;
    var body = response.data;
    if (body is Map && body.containsKey('message')) {
      return body['message'];
    }
  }
  return "Dio response error: ${dioError.message}";
}