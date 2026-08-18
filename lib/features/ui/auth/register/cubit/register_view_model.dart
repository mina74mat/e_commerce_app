import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/use_cases/register_use_case.dart';
import 'package:e_commerce_app/features/ui/auth/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<AuthStates>{
  RegisterUseCase registerUseCase ;
  RegisterViewModel({required this.registerUseCase}):super(AuthInitialState());
  //todo: hold data - handle logic
  var formKey = GlobalKey<FormState>();

  void register({required String email, required String password,
  required String phone , required String name , required
  String rePassword})async{
    if(formKey.currentState?.validate() == true){
      try{
        emit(AuthLoadingState());
        var registerRequest = RegisterRequest(name: name, email: email,
            phone: phone, password: password, rePassword: rePassword);
        var response = await registerUseCase.invoke(registerRequest);
        emit(AuthSuccessState(authResponse: response));
      }on AppException catch (e){
        emit(AuthErrorState(message: e.message));
      }on DioException catch(e){
        final message = (e.error is AppException)
            ? (e.error as AppException).message :
            'unExpected error occurred';
        emit(AuthErrorState(message: message));
      }
    }
  }

}