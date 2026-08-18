import 'package:e_commerce_app/api/model/request/login_request_dto.dart';
import 'package:e_commerce_app/domain/entities/request/login_request.dart';

extension LoginRequestMapper on LoginRequest{
  LoginRequestDto toLoginRequestDto() {
    return LoginRequestDto(
        email: email,
        password: password
    );
  }
}