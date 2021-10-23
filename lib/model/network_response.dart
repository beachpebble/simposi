import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;

import 'errors.dart';

abstract class NetworkResponse extends Equatable {}

class NetworkResponseSuccess extends NetworkResponse {
  final dynamic data;
  final String? message;

  NetworkResponseSuccess({this.data, this.message});

  @override
  List<Object> get props => [data];

  static NetworkResponseSuccess fromJson(Map json) {
    var data = json.containsKey('data') ? json['data'] : null;
    var message = json.containsKey('message') ? json['message'] : null;
    return NetworkResponseSuccess(data: data, message: message);
  }
}

class NetworkResponseError extends NetworkResponse {
  final String message;
  final int status;

  NetworkResponseError(this.message, this.status);

  @override
  List<Object> get props => [message, status];

  static NetworkResponseError fromJson(Map json) {
    if (!json.containsKey('error') && json.containsKey('status')) {
      Map error = json['error'];
      if (error.containsKey('message')) {
        return NetworkResponseError(error['message'], json['status']);
      } else {
        throw ParseException(message: "ResponseError doesn't contain mandatory fields");
      }
    } else {
      throw ParseException(message: "ResponseError doesn't contain mandatory fields");
    }
  }
}
