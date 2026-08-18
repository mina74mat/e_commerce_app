import 'package:e_commerce_app/api/mapper/auth_response_mapper.dart';
import 'package:e_commerce_app/api/mapper/login_request_mapper.dart';
import 'package:e_commerce_app/api/mapper/register_request_mapper.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:e_commerce_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  WebServices webServices ;
  AuthRemoteDataSourceImpl({required this.webServices});

  @override
  Future<AuthResponse> login(LoginRequest loginRequest)async {
    //todo: LoginRequest => LoginRequestDto
    var authResponse = await  webServices.login(loginRequest.toLoginRequestDto());
    //todo: AuthResponseDto => AuthResponse
    return authResponse.toAuthResponse() ;
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async{
    //todo: RegisterRequest => RegisterRequestDto
    var authResponse = await  webServices.register(registerRequest.toRegisterRequestDto());
    //todo: AuthResponseDto => AuthResponse
    return authResponse.toAuthResponse() ;
  }


}