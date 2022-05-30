part of 'signup1_create_account_cubit.dart';

abstract class Signup1CreateAccountState extends Equatable {
  const Signup1CreateAccountState();

  @override
  List<Object> get props => [];
}

class Signup1CreateAccountInitial extends Signup1CreateAccountState {}

class Signup1CreateAccountLoading extends Signup1CreateAccountState {}

class Signup1CreateAccountReady extends Signup1CreateAccountState {}

class Signup1CreateAccountError extends Signup1CreateAccountState {
  final dynamic error;

  const Signup1CreateAccountError(this.error);

  String get message {
    if (error is! DioError) {
      return error.toString();
    }

    final response = error.response;
    if (response == null) {
      return error.message;
    }

    final data = response.data;
    if (data is String) {
      return data;
    }

    if (data is Map) {
      final errors = data['errors'];
      final message = (errors['message'] as Map<String, dynamic>);
      final messages = message.values.expand((element) => element).join('\n');
      return messages;
    }

    return error.toString();
  }

  @override
  List<Object> get props => [error];
}
