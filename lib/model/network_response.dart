import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;

import 'errors.dart';

abstract class NetworkResponse extends Equatable {}

class NetworkResponseSuccess extends NetworkResponse {
  final dynamic data;

  NetworkResponseSuccess(this.data);

  @override
  List<Object> get props => [data];

  static NetworkResponseSuccess fromJson(Map json) {
    var data = json.containsKey('data') ? json['data'] : null;
    return NetworkResponseSuccess(data);
  }
}

class NetworkResponseError extends NetworkResponse {
  final String message;
  final int status;

  NetworkResponseError(this.message, this.status);

  @override
  List<Object> get props => [message, status];

  static NetworkResponseError fromJson(Map json) {
    if (!json.containsKey('message') || !json.containsKey('status')) {
      throw ParseException(message: "ResponseError doesn't contain mandatory fields");
    }
    return NetworkResponseError(json['message'], json['status']);
  }
}
