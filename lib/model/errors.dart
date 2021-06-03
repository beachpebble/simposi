enum LocalizedErrorType {
  PARSE_JWT_ERROR,
  PARSE_ERROR
}

class ParseException implements Exception {
  final String message;
  final LocalizedErrorType errorType;

  ParseException(this.errorType, {this.message = ""});

  @override
  String toString() {
    if (message.isNotEmpty)
      return message;
    else
      return "Parse exception";
  }
}
