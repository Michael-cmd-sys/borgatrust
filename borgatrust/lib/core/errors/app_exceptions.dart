// File: lib/core/errors/app_exceptions.dart

/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AppException: $message';
}

/// Network related exceptions
class NetworkException extends AppException {
  const NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class ConnectionException extends NetworkException {
  const ConnectionException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class TimeoutException extends NetworkException {
  const TimeoutException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

/// Authentication related exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class UnauthorizedException extends AuthenticationException {
  const UnauthorizedException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

/// Data related exceptions
class DataException extends AppException {
  const DataException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class ValidationException extends DataException {
  const ValidationException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class CacheException extends DataException {
  const CacheException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

/// UI related exceptions
class UIException extends AppException {
  const UIException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

/// Result class for handling success and error states
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);
}

/// Extension methods for Result
extension ResultExtensions<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
  
  T? get data => isSuccess ? (this as Success<T>).data : null;
  AppException? get exception => isFailure ? (this as Failure<T>).exception : null;
  
  R fold<R>(R Function(T data) onSuccess, R Function(AppException exception) onFailure) {
    if (isSuccess) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Failure<T>).exception);
    }
  }
} 