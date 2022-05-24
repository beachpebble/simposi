import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/model/errors.dart';

abstract class AppCubit<State> extends Cubit<State> with ErrorHandle {
  AppCubit(State state, this.authenticationBloc) : super(state);

  final AuthenticationBloc authenticationBloc;

  LocalizedErrorType handleErrorWithAuth(exception) {
    if (exception is AuthException) {
      authenticationBloc.add(LoggedOut());
      return LocalizedErrorType.AUTH;
    } else if (exception is ServerException) {
      return exception.errorType;
    } else if (exception is DioError) {
      return handleDioException(exception);
    } else {
      return LocalizedErrorType.OTHER;
    }
  }
}

mixin ErrorHandle {
  String getErrorMessage(error) {
    if (error is ServerException) {
      return error.message;
    } else if (error is Exception) {
      return error.toString();
    } else {
      return "Unknown error";
    }
  }
}

LocalizedErrorType handleDioException(DioError exception) {
  switch (exception.type) {
    case DioErrorType.response:
      return LocalizedErrorType.DIO_DEFAULT;
    case DioErrorType.cancel:
      return LocalizedErrorType.DIO_DEFAULT;
    case DioErrorType.connectTimeout:
      return LocalizedErrorType.DIO_TIMEOUT;
    case DioErrorType.receiveTimeout:
      return LocalizedErrorType.DIO_TIMEOUT;
    case DioErrorType.sendTimeout:
      return LocalizedErrorType.DIO_TIMEOUT;
    case DioErrorType.other:
      final dynamic error = exception.error;
      if (error is SocketException) {
        return LocalizedErrorType.NETWORK;
      } else {
        return LocalizedErrorType.DIO_DEFAULT;
      }
    default:
      return LocalizedErrorType.DIO_DEFAULT;
  }
}


