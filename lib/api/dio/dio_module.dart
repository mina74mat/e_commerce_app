import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/api_endpoints.dart';
import 'package:e_commerce_app/api/dio/dio_interceptors.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GetItModule{
  @singleton
  @injectable
  BaseOptions provideBaseOptions(){
    return BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
  }

  @singleton
  @injectable
  PrettyDioLogger providePrettyDioLogger(){
    return PrettyDioLogger(
      request: true ,
      responseBody: true,
      requestBody: true,
      responseHeader: true ,
      requestHeader: true,
      error: true
    );
  }

  @singleton
  @injectable
  Dio provideDio(BaseOptions baseOptions,PrettyDioLogger prettyDioLogger){
    var dio =  Dio(baseOptions);
    //todo: dio interceptors
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(prettyDioLogger);
    return dio ;
  }
  @singleton
  @injectable
  WebServices provideWebServices(Dio dio) => WebServices(dio);
}