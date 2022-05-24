import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum LocalizedErrorType {
  PARSE_ERROR,
  AUTH,
  SERVER_ERROR,
  DIO_TIMEOUT,
  DIO_DEFAULT,
  NETWORK,
  OTHER,
  UNEXPECTED,
  APP_STATE
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
    if (message.isNotEmpty) {
      return message;
    } else {
      return "Parse exception";
    }
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
    if (message.isNotEmpty) {
      return message;
    } else {
      return "Unknown ServerException";
    }
  }
}


class AuthException extends ServerException {
  AuthException({String message = ""})
      : super(errorType: LocalizedErrorType.AUTH, message: message);
}

//TODO LOcalize
String handleError(exception, BuildContext context) {
  if (exception is AuthException) {
      return "Auth error ${exception.message}";
  } else if (exception is ServerException) {
    return "Server error ${exception.message}";
  } else if (exception is DioError) {
    return getDioException(exception, context);
  } else if (exception is ParseException) {
    return "Data parse error";
  } if (exception is String ){
    return exception;
  }else {
    return "Unknown error";
  }
}

//TODO LOcalize
String getDioException(DioError dioError, BuildContext context) {
  switch (dioError.type) {
    case DioErrorType.response:
      return "Server error: ${getDioResponseError(dioError)}";
      case DioErrorType.cancel:
      return "Request cancelled";
    case DioErrorType.connectTimeout:
      return "Connection timeout";
    case DioErrorType.receiveTimeout:
      return "receive timeout";
    case DioErrorType.sendTimeout:
      return "Send timeout timeout";
    case DioErrorType.other:
      final dynamic error = dioError.error;
      if (error is SocketException) {
        return "Network error";
      } else {
        return dioError.message.isEmpty == true ? "Unknown Dio error" : dioError.message;
      }
    default:
      return dioError.message.isEmpty == true ? "Unknown Dio error" : dioError.message;
  }
}

String getDioResponseError(DioError dioError) {
  if (dioError.type == DioErrorType.response && dioError.response != null) {
    final response = dioError.response!;
    try {
      final body = response.data is String ? jsonDecode(response.data) : response.data;
      if (body is Map && body.containsKey('error')) {
        final Map? error = body['error'];
        if (error != null && error.containsKey('message')) {
          final message = error['message'];
          if (message is String) {
            return message;
          } else if (message is Map) {
            var error = "";
            for(final List f in message.values) {
              final fs = f.join(", ");
              error += fs;
            }
            return error;
          }

        }
      }
    } catch (e) {

    }
  }
  return "Dio response error: ${dioError.message}";
}