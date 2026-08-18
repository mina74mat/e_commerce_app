import 'package:e_commerce_app/api/model/request/register_request_dto.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';

extension RegisterRequestMapper on RegisterRequest{
  RegisterRequestDto toRegisterRequestDto(){
    return RegisterRequestDto(
      password: password,
      email: email,
      rePassword:rePassword ,
      phone: phone,
      name: name
    );
  }
}