import 'package:e_commerce_app/api/mapper/user_mapper.dart';
import 'package:e_commerce_app/api/model/response/auth_response_dto.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

extension AuthResponseMapper on AuthResponseDto {
  AuthResponse toAuthResponse() {
    if (token != null && token!.isNotEmpty) {
      return AuthResponse(user: user?.toUserDto(), token: token);
    }
    throw ServerException(message: message ?? 'Failed Authentication');
  }
}