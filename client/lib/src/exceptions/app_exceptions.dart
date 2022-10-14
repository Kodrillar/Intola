class AppException implements Exception {
  AppException([this.message]);
  final String? message;

  @override
  String toString() => '$message';
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message);
}

class UnauthorizedRequestException extends AppException {
  UnauthorizedRequestException([String? message]) : super(message);
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException([String? message]) : super(message);
}
