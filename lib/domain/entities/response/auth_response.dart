import 'package:e_commerce_app/domain/entities/response/user.dart';

class AuthResponse{
  User? user ;
  String? token ;

  AuthResponse({required this.user,required this.token});
}