import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';
import 'package:e_commerce_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase{
  AuthRepository authRepository ;
  LoginUseCase({required this.authRepository});

 Future<AuthResponse> invoke(LoginRequest loginRequest){
    return authRepository.login(loginRequest);
  }
}