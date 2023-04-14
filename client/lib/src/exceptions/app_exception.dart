import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException {
  factory AppException.dissabledNetworkException(String message) =
      DissabledNetworkException;
  factory AppException.badRequestException(String message) =
      BadRequestException;
  factory AppException.unauthorizedRequestException(String message) =
      UnauthorizedRequestException;
  factory AppException.emptyResourceException(String message) =
      EmptyResourceException;
  factory AppException.serverErrorException(String message) =
      ServerErrorException;
  factory AppException.forbiddenRequestException(String message) =
      ForbiddenRequestException;
  factory AppException.unhandledResponseCodeException(String message) =
      UncaughtResponseCodeException;
  factory AppException.clientException(String message) = ClientException;
}

extension CustomSocketExceptionMessage on SocketException {
  String get customMessage =>
      "Unable to connect to a network. Turn on mobile data or WiFi.";
}

extension CustomFormatExceptionMessage on FormatException {
  String get customMessage =>
      "Client error: a client-side exception has happened!";
}

extension ErrorCode on AppException {
  int get errorCode {
    return when(
      dissabledNetworkException: (message) => 4000,
      badRequestException: (message) => 4001,
      unauthorizedRequestException: (message) => 4002,
      emptyResourceException: (message) => 5000,
      serverErrorException: (message) => 5001,
      forbiddenRequestException: (message) => 5002,
      unhandledResponseCodeException: (message) => 5003,
      clientException: (message) => 5004,
    );
  }
}
