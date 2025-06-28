// File: lib/core/network/dio_client.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../errors/app_exceptions.dart';

/// Dio client provider for dependency injection
final dioProvider = Provider<Dio>((ref) {
  return DioClient.createDio();
});

/// Dio client configuration and setup
class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
        sendTimeout: Duration(milliseconds: AppConstants.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      _LoggingInterceptor(),
      _AuthInterceptor(),
      _ErrorInterceptor(),
      _RetryInterceptor(),
    ]);

    return dio;
  }
}

/// Logging interceptor for debugging
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
    print('🌐 REQUEST[${options.method}] => DATA: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('✅ RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('❌ ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    super.onError(err, handler);
  }
}

/// Authentication interceptor for adding auth tokens
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: Get token from secure storage
    // final token = await SecureStorage.getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // TODO: Handle token refresh or logout
      print('🔄 Token expired, attempting refresh...');
    }
    super.onError(err, handler);
  }
}

/// Error handling interceptor
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException('Request timeout');
        break;
      case DioExceptionType.connectionError:
        exception = const ConnectionException('No internet connection');
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data?['message'] ?? 'Server error';
        
        switch (statusCode) {
          case 400:
            exception = ValidationException(message);
            break;
          case 401:
            exception = UnauthorizedException(message);
            break;
          case 403:
            exception = const AuthenticationException('Access forbidden');
            break;
          case 404:
            exception = const DataException('Resource not found');
            break;
          case 500:
            exception = const NetworkException('Internal server error');
            break;
          default:
            exception = NetworkException(message);
        }
        break;
      default:
        exception = NetworkException(err.message ?? 'Unknown error');
    }

    // Replace the error with our custom exception
    final customError = DioException(
      requestOptions: err.requestOptions,
      error: exception,
      type: err.type,
    );

    handler.next(customError);
  }
}

/// Retry interceptor for failed requests
class _RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
      err.requestOptions.extra['retryCount'] = 1;
      
      try {
        await Future.delayed(const Duration(seconds: 1));
        final response = await Dio().fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Continue with original error if retry fails
      }
    }
    
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
           err.type == DioExceptionType.connectionTimeout ||
           (err.response?.statusCode ?? 0) >= 500;
  }
} 