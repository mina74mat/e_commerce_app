import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;

    final responseData = err.response?.data;
    String message = 'Something went wrong';

    if (responseData is Map) {
      message = (responseData['errors']?['msg'] as String?) ??
          (responseData['message'] as String?) ??
          message;
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      exception = NetworkException(message: 'No internet connection');
    } else if (err.response?.statusCode != null) {
      exception = ServerException(
        message: message,
        statusCode: err.response?.statusCode,
      );
    } else {
      exception = UnexpectedException(message: message);
    }

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception,
    ));
  }
}

