sealed class AppException implements Exception{
  String message ;
  int? statusCode ;
  AppException({required this.message, this.statusCode});

  @override
  String toString() {
    return message ;
  }
}
class ServerException extends AppException{
  ServerException({required super.message, super.statusCode});
}
class NetworkException extends AppException{
  NetworkException({required super.message,super.statusCode});
}
class UnexpectedException extends AppException{
  UnexpectedException({required super.message,super.statusCode});
}