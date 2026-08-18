import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

abstract class AuthRepository{
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);
}