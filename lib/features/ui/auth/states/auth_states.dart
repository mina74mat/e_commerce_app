import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

sealed class AuthStates{}
class AuthInitialState extends AuthStates{}
class AuthLoadingState extends AuthStates{}
class AuthErrorState extends AuthStates{
  String message ;
  AuthErrorState({required this.message});
}
class AuthSuccessState extends AuthStates{
  AuthResponse authResponse ;
  AuthSuccessState({required this.authResponse});
}