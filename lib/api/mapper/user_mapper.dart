import 'package:e_commerce_app/api/model/response/user_dto.dart';
import 'package:e_commerce_app/domain/entities/response/user.dart';

extension UserMapper on UserDto{
  User toUserDto(){
    return User(name: name, email: email);
  }
}