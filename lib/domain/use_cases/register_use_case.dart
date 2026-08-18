import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';
import 'package:e_commerce_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase{
  AuthRepository authRepository ;
  RegisterUseCase({required this.authRepository});

 Future<AuthResponse> invoke(RegisterRequest registerRequest){
    return authRepository.register(registerRequest);
  }
}