### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\data_sources\remote\auth_remote_data_source_impl.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\data_sources\remote\brand_remote_data_source_impl.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/mapper/category_mapper.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/data/data_sources/remote/brand_remote_data_source.dart';
import 'package:e_commerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:BrandRemoteDataSource )
class BrandRemoteDataSourceImpl implements BrandRemoteDataSource{
  WebServices webServices ;
  BrandRemoteDataSourceImpl({required this.webServices});
  @override
  Future<List<Category>?> getAllBrands()async {
    try{
      var categoryResponse = await webServices.getAllBrands();
      //todo: List<CategoryDto> => List<Category>
      return categoryResponse.data?.map((categoryDto)=> categoryDto.toCategory()).toList() ?? [] ;
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }

  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\data_sources\remote\cart_remote_data_source_impl.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/mapper/add_cart_response_mapper.dart';
import 'package:e_commerce_app/api/mapper/get_cart_response_mapper.dart';
import 'package:e_commerce_app/api/model/request/add_product_request_dto.dart';
import 'package:e_commerce_app/api/model/request/count_request_dto.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exceptions/app_exception.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource{
  WebServices webServices ;
  CartRemoteDataSourceImpl({required this.webServices});
  @override
  Future<AddCartResponse> addCart(String productId)async {
    try{
      AddProductRequestDto productRequest = AddProductRequestDto(
        productId: productId
      );
      String? token = SharedPrefsUtils.getData(key: 'token') as String?;
      var addCartResponse = await webServices.addToCart(productRequest, token ??'');
      //todo: addCartResponseDto => addCartResponse
      return addCartResponse.toAddCartResponse();
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }
  }

  @override
  Future<GetCartResponse> getItemsCart()async {
    try{
      String? token = SharedPrefsUtils.getData(key: 'token') as String?;
      var getCartResponse = await webServices.getItemsInCart(token ?? '');
      //todo: getCartResponseDto => getCartResponse
      return getCartResponse.toGetCartResponse();
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }
  }

  @override
  Future<GetCartResponse> deleteItemsCart(String productId) async{
    try{
      String? token = SharedPrefsUtils.getData(key: 'token') as String?;
      var deleteCartResponse = await webServices.deleteItemsInCart(productId,token ?? '');
      //todo: getCartResponseDto => getCartResponse
      return deleteCartResponse.toGetCartResponse();
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }
  }

  @override
  Future<GetCartResponse> updateCountsCart(String productId, int count)async {
    try{
      String? token = SharedPrefsUtils.getData(key: 'token') as String?;
      CountRequestDto countRequest = CountRequestDto(
        count: '$count'
      );
      var updateCartResponse = await webServices.updateCountsInCart(productId,token ?? '',
        countRequest
      );
      //todo: getCartResponseDto => getCartResponse
      return updateCartResponse.toGetCartResponse();
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\data_sources\remote\category_remote_data_source_impl.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/mapper/category_mapper.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:CategoryRemoteDataSource )
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource{
  WebServices webServices ;
  CategoryRemoteDataSourceImpl({required this.webServices});
  @override
  Future<List<Category>?> getAllCategories()async {
    try{
      var categoryResponse = await webServices.getAllCategories();
      //todo: List<CategoryDto> => List<Category>
      return categoryResponse.data?.map((categoryDto)=> categoryDto.toCategory()).toList() ?? [] ;
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }

  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\data_sources\remote\product_remote_data_source_impl.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/mapper/category_mapper.dart';
import 'package:e_commerce_app/api/mapper/product_mapper.dart';
import 'package:e_commerce_app/api/web_services.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/data/data_sources/remote/brand_remote_data_source.dart';
import 'package:e_commerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:e_commerce_app/data/data_sources/remote/product_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:ProductRemoteDataSource )
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource{
  WebServices webServices ;
  ProductRemoteDataSourceImpl({required this.webServices});
  @override
  Future<List<Product>?> getAllProducts()async {
    try{
      var productResponse = await webServices.getAllProducts();
      //todo: List<ProductDto> => List<Product>
      return productResponse.data?.map((productDto)=>productDto.toProduct()).toList() ?? [] ;
    }on DioException catch(e){
      String message = (e.error as AppException).message ;
      throw ServerException(message: message);
    }

  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\dio\dio_interceptors.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;

    final responseData = err.response?.data;
    String message = 'Something went wrong';

    if (responseData is Map) {
      message = (responseData['errors']?['msg'] as String?) ??
          (responseData['message'] as String?) ??
          message;
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      exception = NetworkException(message: 'No internet connection');
    } else if (err.response?.statusCode != null) {
      exception = ServerException(
        message: message,
        statusCode: err.response?.statusCode,
      );
    } else {
      exception = UnexpectedException(message: message);
    }

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception,
    ));
  }
}



``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\dio\dio_module.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\add_cart_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/add_product_mapper.dart';
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_cart_dto.dart';
import 'package:e_commerce_app/domain/entities/response/add_cart.dart';

extension AddCartMapper on AddCartDto{
  AddCart toAddCart(){
    return AddCart(
      id: id,
      products: products?.map((addProductDto)=>addProductDto.toAddProduct()).toList()??[],
      v: v,
      totalCartPrice: totalCartPrice,
      cartOwner: cartOwner,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\add_cart_response_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/add_cart_mapper.dart';
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_cart_response_dto.dart';
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';

extension AddCartResponseMapper on AddCartResponseDto{
  AddCartResponse toAddCartResponse(){
    return AddCartResponse(
      status: status,
      numOfCartItems: numOfCartItems,
      data: data!.toAddCart(),
      cartId: cartId,
      message: message
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\add_product_mapper.dart
`dart
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_product_dto.dart';
import 'package:e_commerce_app/domain/entities/response/add_product.dart';

extension AddProductMapper on AddProductDto{
  AddProduct toAddProduct(){
    return AddProduct(
      id: id,
      product: product,
      count: count,
      price: price
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\auth_response_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/user_mapper.dart';
import 'package:e_commerce_app/api/model/response/auth_response_dto.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

extension AuthResponseMapper on AuthResponseDto{
  AuthResponse toAuthResponse(){
    if(user != null &&  token!.isNotEmpty &&token != null){
      return AuthResponse(
          user: user!.toUserDto(),
          token: token
      );
    }
    throw ServerException(message: 'Failed Authentication');
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\category_mapper.dart
`dart
import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';

extension CategoryMapper on CategoryDto{
 Category toCategory(){
    return Category(
      name: name,
      slug: slug,
      id: id,
      image: image
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\get_cart_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/get_products_mapper.dart';
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_cart_dto.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart.dart';

extension GetCartMapper on GetCartDto{
  GetCart toGetCart(){
    return GetCart(
      id: id,
      cartOwner: cartOwner,
      totalCartPrice: totalCartPrice,
      v: v,
      products: products?.map((getProductDto)=>getProductDto.toGetProducts()).toList()??[]
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\get_cart_response_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/get_cart_mapper.dart';
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_cart_response_dto.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';

extension GetCartResponseMapper on GetCartResponseDto{
  GetCartResponse toGetCartResponse(){
    return GetCartResponse(
      cartId: cartId,
      data: data!.toGetCart(),
      numOfCartItems: numOfCartItems,
      status: status
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\get_products_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/product_mapper.dart';
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_products_dto.dart';
import 'package:e_commerce_app/domain/entities/response/get_products.dart';

extension GetProductsMapper on GetProductsDto{
  GetProducts toGetProducts(){
    return GetProducts(
      id: id,
      price: price,
      count: count,
      product: product!.toProduct()
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\login_request_mapper.dart
`dart
import 'package:e_commerce_app/api/model/request/login_request_dto.dart';
import 'package:e_commerce_app/domain/entities/request/login_request.dart';

extension LoginRequestMapper on LoginRequest{
  LoginRequestDto toLoginRequestDto() {
    return LoginRequestDto(
        email: email,
        password: password
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\product_mapper.dart
`dart
import 'package:e_commerce_app/api/mapper/category_mapper.dart';
import 'package:e_commerce_app/api/mapper/subcategory_mapper.dart';
import 'package:e_commerce_app/api/model/response/common/product_dto.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';

extension ProductMapper on ProductDto{
 Product toProduct(){
    return Product(
      id: id,
      slug: slug,
      category: category!.toCategory(),
      title: title,
      description: description,
      brand: brand!.toCategory(),
      imageCover: imageCover,
      images: images,
      price: price,
      quantity: quantity,
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
      sold: sold,
      subcategory: subcategory?.map((subcategory)=>subcategory.toSubCategory()).toList()??[]
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\register_request_mapper.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\subcategory_mapper.dart
`dart
import 'package:e_commerce_app/api/model/response/common/sub_category_dto.dart';
import 'package:e_commerce_app/domain/entities/response/sub_category.dart';

extension SubcategoryMapper on SubcategoryDto{
 Subcategory toSubCategory(){
    return Subcategory(
      name: name,
      slug: slug,
      id: id,
      category: category
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\mapper\user_mapper.dart
`dart
import 'package:e_commerce_app/api/model/response/user_dto.dart';
import 'package:e_commerce_app/domain/entities/response/user.dart';

extension UserMapper on UserDto{
  User toUserDto(){
    return User(name: name, email: email);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\add_product_request_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';

part 'add_product_request_dto.g.dart';

@JsonSerializable()
class AddProductRequestDto {
  @JsonKey(name: "productId")
  final String? productId;

  AddProductRequestDto ({
    this.productId,
  });

  factory AddProductRequestDto.fromJson(Map<String, dynamic> json) {
    return _$AddProductRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductRequestDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\add_product_request_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductRequestDto _$AddProductRequestDtoFromJson(
        Map<String, dynamic> json) =>
    AddProductRequestDto(
      productId: json['productId'] as String?,
    );

Map<String, dynamic> _$AddProductRequestDtoToJson(
        AddProductRequestDto instance) =>
    <String, dynamic>{
      'productId': instance.productId,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\count_request_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';

part 'count_request_dto.g.dart';

@JsonSerializable()
class CountRequestDto {
  @JsonKey(name: "count")
  final String? count;

  CountRequestDto ({
    this.count,
  });

  factory CountRequestDto.fromJson(Map<String, dynamic> json) {
    return _$CountRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CountRequestDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\count_request_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountRequestDto _$CountRequestDtoFromJson(Map<String, dynamic> json) =>
    CountRequestDto(
      count: json['count'] as String?,
    );

Map<String, dynamic> _$CountRequestDtoToJson(CountRequestDto instance) =>
    <String, dynamic>{
      'count': instance.count,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\login_request_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  LoginRequestDto ({
    this.email,
    this.password,
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginRequestDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\login_request_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    LoginRequestDto(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(LoginRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\register_request_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "rePassword")
  final String? rePassword;
  @JsonKey(name: "phone")
  final String? phone;

  RegisterRequestDto ({
    this.name,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterRequestDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\request\register_request_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDto _$RegisterRequestDtoFromJson(Map<String, dynamic> json) =>
    RegisterRequestDto(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      rePassword: json['rePassword'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$RegisterRequestDtoToJson(RegisterRequestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'rePassword': instance.rePassword,
      'phone': instance.phone,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\brands\brand_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/api/model/response/common/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'brand_response_dto.g.dart';

@JsonSerializable()
class BrandResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryDto>? data;

  BrandResponseDto ({
    this.results,
    this.metadata,
    this.data,
  });

  factory BrandResponseDto.fromJson(Map<String, dynamic> json) {
    return _$BrandResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandResponseDtoToJson(this);
  }
}





``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\brands\brand_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandResponseDto _$BrandResponseDtoFromJson(Map<String, dynamic> json) =>
    BrandResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandResponseDtoToJson(BrandResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_cart_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_cart_dto.g.dart';
@JsonSerializable()
class AddCartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "cartOwner")
  final String? cartOwner;
  @JsonKey(name: "products")
  final List<AddProductDto>? products;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "totalCartPrice")
  final int? totalCartPrice;

  AddCartDto ({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  factory AddCartDto.fromJson(Map<String, dynamic> json) {
    return _$AddCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddCartDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_cart_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartDto _$AddCartDtoFromJson(Map<String, dynamic> json) => AddCartDto(
      id: json['_id'] as String?,
      cartOwner: json['cartOwner'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => AddProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      totalCartPrice: (json['totalCartPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddCartDtoToJson(AddCartDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cartOwner': instance.cartOwner,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'totalCartPrice': instance.totalCartPrice,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_cart_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_cart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_cart_response_dto.g.dart';

@JsonSerializable()
class AddCartResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cartId")
  final String? cartId;
  @JsonKey(name: "data")
  final AddCartDto? data;

  AddCartResponseDto ({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

  factory AddCartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AddCartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddCartResponseDtoToJson(this);
  }
}








``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_cart_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartResponseDto _$AddCartResponseDtoFromJson(Map<String, dynamic> json) =>
    AddCartResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
      cartId: json['cartId'] as String?,
      data: json['data'] == null
          ? null
          : AddCartDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCartResponseDtoToJson(AddCartResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'numOfCartItems': instance.numOfCartItems,
      'cartId': instance.cartId,
      'data': instance.data,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_product_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';
part 'add_product_dto.g.dart';
@JsonSerializable()
class AddProductDto {
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "product")
  final String? product;
  @JsonKey(name: "price")
  final int? price;

  AddProductDto ({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  factory AddProductDto.fromJson(Map<String, dynamic> json) {
    return _$AddProductDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\add_cart\add_product_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductDto _$AddProductDtoFromJson(Map<String, dynamic> json) =>
    AddProductDto(
      count: (json['count'] as num?)?.toInt(),
      id: json['_id'] as String?,
      product: json['product'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddProductDtoToJson(AddProductDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_cart_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_products_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_cart_dto.g.dart';
@JsonSerializable()
class GetCartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "cartOwner")
  final String? cartOwner;
  @JsonKey(name: "products")
  final List<GetProductsDto>? products;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "totalCartPrice")
  final int? totalCartPrice;

  GetCartDto ({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  factory GetCartDto.fromJson(Map<String, dynamic> json) {
    return _$GetCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetCartDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_cart_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartDto _$GetCartDtoFromJson(Map<String, dynamic> json) => GetCartDto(
      id: json['_id'] as String?,
      cartOwner: json['cartOwner'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => GetProductsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      totalCartPrice: (json['totalCartPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetCartDtoToJson(GetCartDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cartOwner': instance.cartOwner,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'totalCartPrice': instance.totalCartPrice,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_cart_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_cart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_cart_response_dto.g.dart';

@JsonSerializable()
class GetCartResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cartId")
  final String? cartId;
  @JsonKey(name: "data")
  final GetCartDto? data;

  GetCartResponseDto ({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

  factory GetCartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$GetCartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetCartResponseDtoToJson(this);
  }
}










``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_cart_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartResponseDto _$GetCartResponseDtoFromJson(Map<String, dynamic> json) =>
    GetCartResponseDto(
      status: json['status'] as String?,
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
      cartId: json['cartId'] as String?,
      data: json['data'] == null
          ? null
          : GetCartDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCartResponseDtoToJson(GetCartResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'numOfCartItems': instance.numOfCartItems,
      'cartId': instance.cartId,
      'data': instance.data,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_products_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/common/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_products_dto.g.dart';
@JsonSerializable()
class GetProductsDto {
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "product")
  final ProductDto? product;
  @JsonKey(name: "price")
  final int? price;

  GetProductsDto ({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  factory GetProductsDto.fromJson(Map<String, dynamic> json) {
    return _$GetProductsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProductsDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\cart\get_cart\get_products_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsDto _$GetProductsDtoFromJson(Map<String, dynamic> json) =>
    GetProductsDto(
      count: (json['count'] as num?)?.toInt(),
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : ProductDto.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetProductsDtoToJson(GetProductsDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\category\category_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/api/model/response/common/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryDto>? data;

  CategoryResponseDto ({
    this.results,
    this.metadata,
    this.data,
  });

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryResponseDtoToJson(this);
  }
}








``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\category\category_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponseDto _$CategoryResponseDtoFromJson(Map<String, dynamic> json) =>
    CategoryResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseDtoToJson(
        CategoryResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\category_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';
part 'category_dto.g.dart';
@JsonSerializable()
class CategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  CategoryDto ({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return _$CategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\category_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\metadata_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';
part 'metadata_dto.g.dart';
@JsonSerializable()
class MetadataDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "nextPage")
  final int? nextPage;

  MetadataDto ({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage
  });

  factory MetadataDto.fromJson(Map<String, dynamic> json) {
    return _$MetadataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\metadata_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataDto _$MetadataDtoFromJson(Map<String, dynamic> json) => MetadataDto(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataDtoToJson(MetadataDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
      'nextPage': instance.nextPage,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\product_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/api/model/response/common/sub_category_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_dto.g.dart';
@JsonSerializable()
class ProductDto {
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "subcategory")
  final List<SubcategoryDto>? subcategory;
  @JsonKey(name: "ratingsQuantity")
  final int? ratingsQuantity;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "imageCover")
  final String? imageCover;
  @JsonKey(name: "category")
  final CategoryDto? category;
  @JsonKey(name: "brand")
  final CategoryDto? brand;
  @JsonKey(name: "ratingsAverage")
  final double? ratingsAverage;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  ProductDto ({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return _$ProductDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\product_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      sold: (json['sold'] as num?)?.toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      subcategory: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => SubcategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratingsQuantity: (json['ratingsQuantity'] as num?)?.toInt(),
      id: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      imageCover: json['imageCover'] as String?,
      category: json['category'] == null
          ? null
          : CategoryDto.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : CategoryDto.fromJson(json['brand'] as Map<String, dynamic>),
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'sold': instance.sold,
      'images': instance.images,
      'subcategory': instance.subcategory,
      'ratingsQuantity': instance.ratingsQuantity,
      '_id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'imageCover': instance.imageCover,
      'category': instance.category,
      'brand': instance.brand,
      'ratingsAverage': instance.ratingsAverage,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\sub_category_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';
part 'sub_category_dto.g.dart';
@JsonSerializable()
class SubcategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "category")
  final String? category;

  SubcategoryDto ({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  factory SubcategoryDto.fromJson(Map<String, dynamic> json) {
    return _$SubcategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubcategoryDtoToJson(this);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\common\sub_category_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryDto _$SubcategoryDtoFromJson(Map<String, dynamic> json) =>
    SubcategoryDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$SubcategoryDtoToJson(SubcategoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'category': instance.category,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\products\product_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/common/metadata_dto.dart';
import 'package:e_commerce_app/api/model/response/common/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_response_dto.g.dart';

@JsonSerializable()
class ProductResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "data")
  final List<ProductDto>? data;

  ProductResponseDto ({
    this.results,
    this.metadata,
    this.data,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductResponseDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\products\product_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseDto _$ProductResponseDtoFromJson(Map<String, dynamic> json) =>
    ProductResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseDtoToJson(ProductResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\auth_response_dto.dart
`dart
import 'package:e_commerce_app/api/model/response/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;
  @JsonKey(name: "token")
  final String? token;

  AuthResponseDto ({
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseDtoToJson(this);
  }
}




``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\auth_response_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseDto _$AuthResponseDtoFromJson(Map<String, dynamic> json) =>
    AuthResponseDto(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthResponseDtoToJson(AuthResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'token': instance.token,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\user_dto.dart
`dart
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "role")
  final String? role;

  UserDto ({
    this.name,
    this.email,
    this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\model\response\user_dto.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
    };


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\api_endpoints.dart
`dart
class ApiEndPoints{
  static const String baseUrl = 'https://ecommerce.routemisr.com/';
  static const String loginApi = 'api/v1/auth/signin';
  static const String registerApi = 'api/v1/auth/signup';
  static const String categoriesApi = 'api/v1/categories';
  static const String brandsApi = 'api/v1/brands';
  static const String productsApi = 'api/v1/products';
  static const String addToCartApi = 'api/v1/cart';
  static const String deleteCartApi = 'api/v1/cart/{productId}';
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\web_services.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/api_endpoints.dart';
import 'package:e_commerce_app/api/model/request/add_product_request_dto.dart';
import 'package:e_commerce_app/api/model/request/count_request_dto.dart';
import 'package:e_commerce_app/api/model/request/login_request_dto.dart';
import 'package:e_commerce_app/api/model/request/register_request_dto.dart';
import 'package:e_commerce_app/api/model/response/auth_response_dto.dart';
import 'package:e_commerce_app/api/model/response/brands/brand_response_dto.dart';
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_cart_dto.dart';
import 'package:e_commerce_app/api/model/response/cart/add_cart/add_cart_response_dto.dart';
import 'package:e_commerce_app/api/model/response/cart/get_cart/get_cart_response_dto.dart';
import 'package:e_commerce_app/api/model/response/category/category_response_dto.dart';
import 'package:e_commerce_app/api/model/response/products/product_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi()
abstract class WebServices {
  factory WebServices(Dio dio, {String? baseUrl}) = _WebServices;

  @POST(ApiEndPoints.loginApi)
  Future<AuthResponseDto> login(@Body() LoginRequestDto loginRequest);

  @POST(ApiEndPoints.registerApi)
  Future<AuthResponseDto> register(@Body() RegisterRequestDto registerRequest);
  
  @GET(ApiEndPoints.categoriesApi)
  Future<CategoryResponseDto> getAllCategories();

  @GET(ApiEndPoints.brandsApi)
  Future<BrandResponseDto> getAllBrands();

  @GET(ApiEndPoints.productsApi)
  Future<ProductResponseDto> getAllProducts();
  
  @POST(ApiEndPoints.addToCartApi)
  Future<AddCartResponseDto> addToCart(
      @Body() AddProductRequestDto productRequest ,
      @Header('token') String token
      );

  @GET(ApiEndPoints.addToCartApi)
  Future<GetCartResponseDto> getItemsInCart(
      @Header('token') String token
      );
  
  @DELETE(ApiEndPoints.deleteCartApi)
  Future<GetCartResponseDto> deleteItemsInCart(
      @Path('productId') String productId,
      @Header('token') String token
      );

  @PUT(ApiEndPoints.deleteCartApi)
  Future<GetCartResponseDto> updateCountsInCart(
      @Path('productId') String productId,
      @Header('token') String token,
      @Body() CountRequestDto countRequest
      );
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\api\web_services.g.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _WebServices implements WebServices {
  _WebServices(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<AuthResponseDto> login(LoginRequestDto loginRequest) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest.toJson());
    final _options = _setStreamType<AuthResponseDto>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/auth/signin',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponseDto _value;
    try {
      _value = AuthResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthResponseDto> register(RegisterRequestDto registerRequest) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(registerRequest.toJson());
    final _options = _setStreamType<AuthResponseDto>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/auth/signup',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponseDto _value;
    try {
      _value = AuthResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CategoryResponseDto> getAllCategories() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<CategoryResponseDto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/categories',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late CategoryResponseDto _value;
    try {
      _value = CategoryResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BrandResponseDto> getAllBrands() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BrandResponseDto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/brands',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BrandResponseDto _value;
    try {
      _value = BrandResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ProductResponseDto> getAllProducts() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ProductResponseDto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/products',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductResponseDto _value;
    try {
      _value = ProductResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AddCartResponseDto> addToCart(
    AddProductRequestDto productRequest,
    String token,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(productRequest.toJson());
    final _options = _setStreamType<AddCartResponseDto>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/cart',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AddCartResponseDto _value;
    try {
      _value = AddCartResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetCartResponseDto> getItemsInCart(String token) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetCartResponseDto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/cart',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetCartResponseDto _value;
    try {
      _value = GetCartResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetCartResponseDto> deleteItemsInCart(
    String productId,
    String token,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetCartResponseDto>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/cart/${productId}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetCartResponseDto _value;
    try {
      _value = GetCartResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetCartResponseDto> updateCountsInCart(
    String productId,
    String token,
    CountRequestDto countRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(countRequest.toJson());
    final _options = _setStreamType<GetCartResponseDto>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'api/v1/cart/${productId}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetCartResponseDto _value;
    try {
      _value = GetCartResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\config\di\di.config.dart
`dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../api/data_sources/remote/auth_remote_data_source_impl.dart'
    as _i740;
import '../../api/data_sources/remote/brand_remote_data_source_impl.dart'
    as _i113;
import '../../api/data_sources/remote/cart_remote_data_source_impl.dart'
    as _i406;
import '../../api/data_sources/remote/category_remote_data_source_impl.dart'
    as _i448;
import '../../api/data_sources/remote/product_remote_data_source_impl.dart'
    as _i895;
import '../../api/dio/dio_module.dart' as _i67;
import '../../api/web_services.dart' as _i1069;
import '../../data/data_sources/remote/auth_remote_data_source.dart' as _i865;
import '../../data/data_sources/remote/brand_remote_data_source.dart' as _i114;
import '../../data/data_sources/remote/cart_remote_data_source.dart' as _i489;
import '../../data/data_sources/remote/category_remote_data_source.dart'
    as _i344;
import '../../data/data_sources/remote/product_remote_data_source.dart'
    as _i189;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/brand_repository_impl.dart' as _i90;
import '../../data/repositories/cart_repository_impl.dart' as _i915;
import '../../data/repositories/category_repository_impl.dart' as _i538;
import '../../data/repositories/product_repository_impl.dart' as _i876;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/brands/brand_repository.dart' as _i451;
import '../../domain/repositories/cart/cart_repository.dart' as _i388;
import '../../domain/repositories/category/category_repository.dart' as _i612;
import '../../domain/repositories/products/product_repository.dart' as _i83;
import '../../domain/use_cases/add_to_cart_use_case.dart' as _i1024;
import '../../domain/use_cases/delete_items_in_cart_use_case.dart' as _i87;
import '../../domain/use_cases/get_all_brands_use_case.dart' as _i773;
import '../../domain/use_cases/get_all_categories_use_case.dart' as _i201;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/get_items_cart_use_case.dart' as _i252;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../domain/use_cases/update_count_in_cart_use_case.dart' as _i261;
import '../../features/ui/auth/login/cubit/login_view_model.dart' as _i245;
import '../../features/ui/auth/register/cubit/register_view_model.dart'
    as _i873;
import '../../features/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i98;
import '../../features/ui/pages/home_screen/cubit/home_screen_view_model.dart'
    as _i114;
import '../../features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart'
    as _i524;
import '../../features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart'
    as _i848;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final getItModule = _$GetItModule();
    gh.factory<_i114.HomeScreenViewModel>(() => _i114.HomeScreenViewModel());
    gh.singleton<_i361.BaseOptions>(() => getItModule.provideBaseOptions());
    gh.singleton<_i528.PrettyDioLogger>(
        () => getItModule.providePrettyDioLogger());
    gh.singleton<_i361.Dio>(() => getItModule.provideDio(
          gh<_i361.BaseOptions>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.singleton<_i1069.WebServices>(
        () => getItModule.provideWebServices(gh<_i361.Dio>()));
    gh.factory<_i114.BrandRemoteDataSource>(() =>
        _i113.BrandRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i451.BrandRepository>(() => _i90.BrandRepositoryImpl(
        remoteDataSource: gh<_i114.BrandRemoteDataSource>()));
    gh.factory<_i489.CartRemoteDataSource>(() =>
        _i406.CartRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i344.CategoryRemoteDataSource>(() =>
        _i448.CategoryRemoteDataSourceImpl(
            webServices: gh<_i1069.WebServices>()));
    gh.factory<_i865.AuthRemoteDataSource>(() =>
        _i740.AuthRemoteDataSourceImpl(webServices: gh<_i1069.WebServices>()));
    gh.factory<_i189.ProductRemoteDataSource>(() =>
        _i895.ProductRemoteDataSourceImpl(
            webServices: gh<_i1069.WebServices>()));
    gh.factory<_i773.GetAllBrandsUseCase>(() => _i773.GetAllBrandsUseCase(
        brandRepository: gh<_i451.BrandRepository>()));
    gh.factory<_i83.ProductRepository>(() => _i876.ProductRepositoryImpl(
        remoteDataSource: gh<_i189.ProductRemoteDataSource>()));
    gh.factory<_i612.CategoryRepository>(() => _i538.CategoryRepositoryImpl(
        remoteDataSource: gh<_i344.CategoryRemoteDataSource>()));
    gh.factory<_i1073.AuthRepository>(() => _i895.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i865.AuthRemoteDataSource>()));
    gh.factory<_i388.CartRepository>(() => _i915.CartRepositoryImpl(
        remoteDataSource: gh<_i489.CartRemoteDataSource>()));
    gh.factory<_i471.LoginUseCase>(
        () => _i471.LoginUseCase(authRepository: gh<_i1073.AuthRepository>()));
    gh.factory<_i479.RegisterUseCase>(() =>
        _i479.RegisterUseCase(authRepository: gh<_i1073.AuthRepository>()));
    gh.factory<_i939.GetAllProductsUseCase>(() => _i939.GetAllProductsUseCase(
        productRepository: gh<_i83.ProductRepository>()));
    gh.factory<_i201.GetAllCategoriesUseCase>(() =>
        _i201.GetAllCategoriesUseCase(
            categoryRepository: gh<_i612.CategoryRepository>()));
    gh.factory<_i873.RegisterViewModel>(() =>
        _i873.RegisterViewModel(registerUseCase: gh<_i479.RegisterUseCase>()));
    gh.factory<_i1024.AddToCartUseCase>(() =>
        _i1024.AddToCartUseCase(cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i252.GetItemsCartUseCase>(() =>
        _i252.GetItemsCartUseCase(cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i87.DeleteItemsInCartUseCase>(() =>
        _i87.DeleteItemsInCartUseCase(
            cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i261.UpdateCountInCartUseCase>(() =>
        _i261.UpdateCountInCartUseCase(
            cartRepository: gh<_i388.CartRepository>()));
    gh.factory<_i245.LoginViewModel>(
        () => _i245.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()));
    gh.factory<_i524.HomeTabViewModel>(() => _i524.HomeTabViewModel(
          getAllCategoriesUseCase: gh<_i201.GetAllCategoriesUseCase>(),
          getAllBrandsUseCase: gh<_i773.GetAllBrandsUseCase>(),
        ));
    gh.factory<_i848.ProductTabViewModel>(() => _i848.ProductTabViewModel(
        getAllProductsUseCase: gh<_i939.GetAllProductsUseCase>()));
    gh.factory<_i98.CartViewModel>(() => _i98.CartViewModel(
          addToCartUseCase: gh<_i1024.AddToCartUseCase>(),
          getItemsCartUseCase: gh<_i252.GetItemsCartUseCase>(),
          deleteItemsInCartUseCase: gh<_i87.DeleteItemsInCartUseCase>(),
          updateCountInCartUseCase: gh<_i261.UpdateCountInCartUseCase>(),
        ));
    return this;
  }
}

class _$GetItModule extends _i67.GetItModule {}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\config\di\di.dart
`dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\config\my_bloc_observer.dart
`dart
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\cache\shared_prefs_utils.dart
`dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils{
  static late SharedPreferences sharedPrefs  ;

  static Future<SharedPreferences> init()async{
   return  sharedPrefs = await SharedPreferences.getInstance();
  }
  //todo: save data => write
  static Future<bool> saveData({required String key , required dynamic value})async{
    if(value is int){
      return await sharedPrefs.setInt(key, value);
    }else if(value is double){
      return await sharedPrefs.setDouble(key, value);
    }else if(value is String){
      return await sharedPrefs.setString(key, value);
    }else{
      return await sharedPrefs.setBool(key, value);
    }

  }
 //todo: get data => read
  static Object? getData({required String key}){
    return sharedPrefs.get(key);
  }
 // todo: remove data
  static Future<bool> removeData({required String key})async{
    return await sharedPrefs.remove(key);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\exceptions\app_exception.dart
`dart
sealed class AppException implements Exception{
  String message ;
  int? statusCode ;
  AppException({required this.message, this.statusCode});

  @override
  String toString() {
    return message ;
  }
}
class ServerException extends AppException{
  ServerException({required super.message, super.statusCode});
}
class NetworkException extends AppException{
  NetworkException({required super.message,super.statusCode});
}
class UnexpectedException extends AppException{
  UnexpectedException({required super.message,super.statusCode});
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\app_assets.dart
`dart
class AppAssets {
  // Selected Icons
  static const String selectedHomeIcon = "assets/icons/home_icon_selected.png";
  static const String editIcon = "assets/icons/edit.png";
  static const String selectedCategoryIcon = "assets/icons/category_icon_selected.png";
  static const String selectedAccountIcon = "assets/icons/account_icon_selected.png";
  static const String selectedAddToFavouriteIcon = "assets/icons/add_to_favourite.png";

// Not selected icons
  static const String unSelectedHomeIcon = "assets/icons/home_icon_not_selected.png";
  static const String unSelectedCategoryIcon = "assets/icons/category_icon_not_selected.png";
  static const String unSelectedAccountIcon = "assets/icons/account_icon_not_selected.png";

  // More Icons
  static const String unSelectedFavouriteIcon = "assets/icons/favourite_not_selected.png";
  static const String selectedFavouriteIcon = "assets/icons/favourite_selected.png";
  static const String starIcon = "assets/icons/star.png";
  static const String routeLogo = "assets/icons/route_logo.png";
  static const String shoppingCart = "assets/icons/shopping_cart.png";

  // Announcements Images
  static const String announcement1 = "assets/images/banner-1.png";
  static const String announcement2 = "assets/images/banner-2.png";
  static const String announcement3 = "assets/images/banner-3.png";

  // Categories
  static const String beautyCategory = "assets/images/categories/beauty.png";
  static const String menCategory = "assets/images/categories/men.png";
  static const String womenCategory = "assets/images/categories/women.png";
  static const String skinCareCategory = "assets/images/categories/skincare.png";
  static const String headphoneCategory = "assets/images/categories/headphone.png";
  static const String electronicsCategory = "assets/images/categories/electronics.png";

  // Item
  static const String itemImage = "assets/images/items/wash_machine.png";
  static const String shoesItemImage1 = "assets/images/items/shoes-1.png";
  static const String shoesItemImage2 = "assets/images/items/shoes-2.png";
  static const String shoesItemImage3 = "assets/images/items/shoes-3.png";

  static const String appBarLeading = 'assets/images/Route.png';
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\app_colors.dart
`dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF004182);
  static const Color primary30Opacity = Color(0x4D004182);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color hintTextColor = Color(0xB3000000);
  static const Color primaryDark = Color(0xFF06004F);
  static const Color primaryDarkLight = Color(0x9906004F);
  static const Color searchHintColor = Color(0x9906004F);
  static const Color discountTextColor = Color(0x99004182);
  static const Color orangeColor = Color(0xFFF4B400);
  static const Color yellowColor = Color(0xFFFDD835);
  static const Color lightYellowColor = Color(0xFFFFFF8D);
  static const Color lightBlack = Color(0xFF2F2929);
  static const Color redColor = Color(0xFFBC3018);
  static const Color blueColor = Color(0xFF0973DD);
  static const Color greenColor = Color(0xFF02B935);
  static const Color lightRedColor = Color(0xFFFF645A);
  static const Color transparentColor = Colors.transparent;
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\app_routes.dart
`dart
class AppRoutes {
  static String homeRoute = "home";
  static String productRoute = "productDetails";
  static String cartRoute = "cart";
  static String loginRoute = "login";
  static String registerRoute = "register";
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\app_styles.dart
`dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle regular12Text = GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryDark);
  static TextStyle regular11SalePrice = GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryDark);
  static TextStyle regular14Text = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryDark);
  static TextStyle regular18White = GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.whiteColor);
  static TextStyle light14SearchHint = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: AppColors.searchHintColor);
  static TextStyle light16White = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.whiteColor);
  static TextStyle light18HintText = GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: AppColors.hintTextColor);
  static TextStyle semi16TextWhite = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.whiteColor);
  static TextStyle semi20Primary = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static TextStyle semi24White = GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.whiteColor);
  static TextStyle medium14Category = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryDark);
  static TextStyle medium14LightPrimary = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryDarkLight);
  static TextStyle medium14PrimaryDark = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryDark);
  static TextStyle medium18Header = GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.primaryDark);
  static TextStyle medium18White = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
  static TextStyle medium20White = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\app_theme.dart
`dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
          color: AppColors.primaryColor
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showUnselectedLabels: false, showSelectedLabels: false, elevation: 0),
  );
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\dialog_utils.dart
`dart
import 'package:flutter/material.dart';

import 'app_styles.dart';

class DialogUtils {
  static void showLoading({required BuildContext context, required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message,
                    style: AppStyles.medium18Header,),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({required BuildContext context, required String message, String? title , String? posActionName, Function? posAction, String? negActionName, Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(posActionName,
            style: AppStyles.medium18Header,)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName,
              style: AppStyles.medium18Header)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message,
              style: AppStyles.medium18Header,),
            title: Text(
              title ?? '',
              style: AppStyles.medium18Header,
            ),
            actions: actions,
          );
        });
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\flutter_toast.dart
`dart
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage{
  static Future<bool?> toastMsg(String msg,Color backgroundColor, Color textColor){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 20
    );
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\core\utils\validators.dart
`dart
class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null || val.trim().isEmpty) {
      return 'this field is required';
    } else if (emailRegex.hasMatch(val) == false) {
      return 'enter valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return 'strong password please';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val != password) {
      return 'Passwords not matching';
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (!usernameRegex.hasMatch(val)) {
      return 'enter valid username';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return 'this field is required';
    } else if (int.tryParse(val.trim()) == null) {
      return 'enter numbers only';
    } else if (val.trim().length != 11) {
      return 'enter value must equal 11 digit';
    } else {
      return null;
    }
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\data_sources\remote\auth_remote_data_source.dart
`dart
import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

abstract class AuthRemoteDataSource{
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\data_sources\remote\brand_remote_data_source.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';

abstract class BrandRemoteDataSource{
 Future<List<Category>?> getAllBrands();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\data_sources\remote\cart_remote_data_source.dart
`dart
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';

abstract class CartRemoteDataSource{
  Future<AddCartResponse> addCart(String productId);
  Future<GetCartResponse> getItemsCart();
  Future<GetCartResponse> deleteItemsCart(String productId);
  Future<GetCartResponse> updateCountsCart(String productId, int count);

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\data_sources\remote\category_remote_data_source.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';

abstract class CategoryRemoteDataSource{
 Future<List<Category>?> getAllCategories();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\data_sources\remote\product_remote_data_source.dart
`dart
import 'package:e_commerce_app/domain/entities/response/product.dart';

abstract class ProductRemoteDataSource{
 Future<List<Product>?> getAllProducts();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\repositories\auth_repository_impl.dart
`dart
import 'package:e_commerce_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';
import 'package:e_commerce_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource ;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) {
    return authRemoteDataSource.login(loginRequest);
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) {
    return authRemoteDataSource.register(registerRequest);
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\repositories\brand_repository_impl.dart
`dart
import 'package:e_commerce_app/data/data_sources/remote/brand_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrandRepository)
class BrandRepositoryImpl implements BrandRepository{
  BrandRemoteDataSource remoteDataSource ;
  BrandRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Category>?> getAllBrands() {
    return remoteDataSource.getAllBrands();
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\repositories\cart_repository_impl.dart
`dart
import 'package:e_commerce_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';
import 'package:e_commerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository{
  CartRemoteDataSource remoteDataSource ;
  CartRepositoryImpl({required this.remoteDataSource});
  @override
  Future<AddCartResponse> addCart(String productId) {
   return remoteDataSource.addCart(productId);
  }

  @override
  Future<GetCartResponse> getItemsCart() {
    return remoteDataSource.getItemsCart();
  }

  @override
  Future<GetCartResponse> deleteItemsCart(String productId) {
    return remoteDataSource.deleteItemsCart(productId);
  }

  @override
  Future<GetCartResponse> updateCountsCart(String productId, int count) {
    return remoteDataSource.updateCountsCart(productId, count);
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\repositories\category_repository_impl.dart
`dart
import 'package:e_commerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository{
  CategoryRemoteDataSource remoteDataSource ;
  CategoryRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Category>?> getAllCategories() {
    return remoteDataSource.getAllCategories();
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\data\repositories\product_repository_impl.dart
`dart
import 'package:e_commerce_app/data/data_sources/remote/product_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/domain/repositories/products/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository{
  ProductRemoteDataSource remoteDataSource ;
  ProductRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Product>?> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\request\login_request.dart
`dart
class LoginRequest{
  String? email ;
  String? password ;

  LoginRequest({required this.email,required this.password});


}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\request\register_request.dart
`dart
class RegisterRequest{
  String? email ;
  String? name ;
  String? password ;
  String? rePassword ;
  String? phone ;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword
});
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\add_cart.dart
`dart

import 'package:e_commerce_app/domain/entities/response/add_product.dart';

class AddCart {
  final String? id;
  final String? cartOwner;
  final List<AddProduct>? products;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final int? totalCartPrice;

  AddCart ({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\add_cart_response.dart
`dart

import 'package:e_commerce_app/domain/entities/response/add_cart.dart';

class AddCartResponse{
  final String? status;
  final String? message;
  final int? numOfCartItems;
  final String? cartId;
  final AddCart? data;

  AddCartResponse ({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

}








``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\add_product.dart
`dart
class AddProduct {
  final int? count;
  final String? id;
  final String? product;
  final int? price;

  AddProduct ({
    this.count,
    this.id,
    this.product,
    this.price,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\auth_response.dart
`dart
import 'package:e_commerce_app/domain/entities/response/user.dart';

class AuthResponse{
  User? user ;
  String? token ;

  AuthResponse({required this.user,required this.token});
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\brand_response.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/metadata.dart';

class BrandResponse {
  final int? results;
  final Metadata? metadata;
  final List<Category>? data;

  BrandResponse ({
    this.results,
    this.metadata,
    this.data,
  });

}





``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\category.dart
`dart
class Category {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;

  Category ({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\category_response.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/metadata.dart';

class CategoryResponse{
  final int? results;
  final Metadata? metadata;
  final List<Category>? data;

  CategoryResponse ({
    this.results,
    this.metadata,
    this.data,
  });

}








``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\get_cart.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_products.dart';

class GetCart{
  final String? id;
  final String? cartOwner;
  final List<GetProducts>? products;
  final int? v;
  final int? totalCartPrice;

  GetCart ({
    this.id,
    this.cartOwner,
    this.products,
    this.v,
    this.totalCartPrice,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\get_cart_response.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_cart.dart';

class GetCartResponse{
  final String? status;
  final int? numOfCartItems;
  final String? cartId;
  final GetCart? data;

  GetCartResponse ({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

}










``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\get_products.dart
`dart
import 'package:e_commerce_app/domain/entities/response/product.dart';

class GetProducts {
  final int? count;
  final String? id;
  final Product? product;
  final int? price;

  GetProducts ({
    this.count,
    this.id,
    this.product,
    this.price,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\metadata.dart
`dart
class Metadata {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  Metadata ({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\product.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/sub_category.dart';
class Product {
  final int? sold;
  final List<String>? images;
  final List<Subcategory>? subcategory;
  final int? ratingsQuantity;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? quantity;
  final int? price;
  final String? imageCover;
  final Category? category;
  final Category? brand;
  final double? ratingsAverage;

  Product({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\sub_category.dart
`dart

class Subcategory {
  final String? id;
  final String? name;
  final String? slug;
  final String? category;

  Subcategory ({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\entities\response\user.dart
`dart
class User{
  String? name ;
  String? email ;

  User({required this.name,required this.email});
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\repositories\brands\brand_repository.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';

abstract class BrandRepository{
  Future<List<Category>?> getAllBrands();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\repositories\cart\cart_repository.dart
`dart
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';

abstract class CartRepository{
  Future<AddCartResponse> addCart(String productId);
  Future<GetCartResponse> getItemsCart();
  Future<GetCartResponse> deleteItemsCart(String productId);
  Future<GetCartResponse> updateCountsCart(String productId, int count);
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\repositories\category\category_repository.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';

abstract class CategoryRepository{
  Future<List<Category>?> getAllCategories();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\repositories\products\product_repository.dart
`dart
import 'package:e_commerce_app/domain/entities/response/product.dart';

abstract class ProductRepository{
  Future<List<Product>?> getAllProducts();
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\repositories\auth_repository.dart
`dart
import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth_response.dart';

abstract class AuthRepository{
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\add_to_cart_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase{
  CartRepository cartRepository ;
  AddToCartUseCase({required this.cartRepository});

  Future<AddCartResponse> invoke(String productId){
    return cartRepository.addCart(productId);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\delete_items_in_cart_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';
import 'package:e_commerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteItemsInCartUseCase{
  CartRepository cartRepository ;
  DeleteItemsInCartUseCase({required this.cartRepository});

  Future<GetCartResponse> invoke(String productId){
    return cartRepository.deleteItemsCart(productId);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\get_all_brands_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllBrandsUseCase{
  BrandRepository brandRepository ;
  GetAllBrandsUseCase({required this.brandRepository});

  Future<List<Category>?>invoke(){
    return brandRepository.getAllBrands();
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\get_all_categories_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase{
  CategoryRepository categoryRepository ;
  GetAllCategoriesUseCase({required this.categoryRepository});

  Future<List<Category>?>invoke(){
    return categoryRepository.getAllCategories();
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\get_all_products_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:e_commerce_app/domain/repositories/products/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase{
  ProductRepository productRepository ;
  GetAllProductsUseCase({required this.productRepository});

  Future<List<Product>?>invoke(){
    return productRepository.getAllProducts();
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\get_items_cart_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/add_cart_response.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';
import 'package:e_commerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetItemsCartUseCase{
  CartRepository cartRepository ;
  GetItemsCartUseCase({required this.cartRepository});

  Future<GetCartResponse> invoke(){
    return cartRepository.getItemsCart();
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\login_use_case.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\register_use_case.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\domain\use_cases\update_count_in_cart_use_case.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_cart_response.dart';
import 'package:e_commerce_app/domain/repositories/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCountInCartUseCase{
  CartRepository cartRepository ;
  UpdateCountInCartUseCase({required this.cartRepository});

  Future<GetCartResponse> invoke(String productId, int count){
    return cartRepository.updateCountsCart(productId, count);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\auth\login\cubit\login_view_model.dart
`dart
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/entities/request/login_request.dart';
import 'package:e_commerce_app/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/features/ui/auth/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<AuthStates>{
  LoginUseCase loginUseCase ;
  LoginViewModel({required this.loginUseCase}):super(AuthInitialState());
  //todo: hold data - handle logic
  var formKey = GlobalKey<FormState>();

  void login({required String email, required String password})async{
    if(formKey.currentState?.validate() == true){
      try{
        emit(AuthLoadingState());
        var loginRequest = LoginRequest(email: email, password: password);
        var response = await loginUseCase.invoke(loginRequest);
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\auth\login\login_screen.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/dialog_utils.dart';
import 'package:e_commerce_app/features/ui/auth/login/cubit/login_view_model.dart';
import 'package:e_commerce_app/features/ui/auth/states/auth_states.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: "amira15sun@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "123456@A");

  LoginViewModel viewModel = getIt<LoginViewModel>();


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel,AuthStates>(
      bloc: viewModel,
      listener: (context,state){
        if(state is AuthLoadingState){
          DialogUtils.showLoading(context: context, message: 'Waiting...');
        }else if(state is AuthErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: state.message,
          title: 'Error',posActionName: 'Ok');
        }else if(state is AuthSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'Login Successfully',
              title: 'Success',posActionName: 'Ok',posAction: (){
            //todo: save token
                SharedPrefsUtils.saveData(key: 'token', value: state.authResponse.token??'');
                //todo : navigate to home screen
                Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
              });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 91.h, bottom: 87.h, left: 97.w, right: 97.w),
                  child: Image.asset(
                    AppAssets.appBarLeading,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        'Welcome Back To Route',
                        style: AppStyles.semi24White,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'Please sign in with your mail',
                        style: AppStyles.light16White,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "User Name",
                                style: AppStyles.medium18White,
                              ),
                              CustomTextFormField(
                                  isPassword: false,
                                  keyboardType: TextInputType.text,
                                  isObscureText: false,
                                  hintText: "enter your name",
                                  hintStyle: AppStyles.light18HintText,
                                  filledColor: AppColors.whiteColor,
                                  controller: emailController,
                                  validator: AppValidators.validateEmail),
                              Text(
                                "Password",
                                style: AppStyles.medium18White,
                              ),
                              CustomTextFormField(
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                hintText: "enter your password",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: passwordController,
                                validator: AppValidators.validatePassword,
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.visibility_off)),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password',
                                  style: AppStyles.regular18White,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 35.h),
                                child: CustomElevatedButton(
                                    backgroundColor: AppColors.whiteColor,
                                    textStyle: AppStyles.semi20Primary,
                                    text: "Login",
                                    onPressed: () {
                                      viewModel.login(email: emailController.text,
                                          password: passwordController.text);
                                    }),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 30.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.registerRoute);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Donâ€™t have an account? Create Account',
                                            style: AppStyles.medium18White,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\auth\register\cubit\register_view_model.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\auth\register\register_screen.dart
`dart
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/auth/register/cubit/register_view_model.dart';
import 'package:e_commerce_app/features/ui/auth/states/auth_states.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/validators.dart';

import '../../../../core/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: "ali dekheel");
  TextEditingController phoneController =
      TextEditingController(text: "01100860890");
  TextEditingController mailController =
      TextEditingController(text: "adasdf@fds.com");
  TextEditingController passwordController =
      TextEditingController(text: "15261548@A");
  TextEditingController rePasswordController =
      TextEditingController(text: "15261548@A");

  RegisterViewModel viewModel = getIt<RegisterViewModel>();


  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel,AuthStates>(
      bloc: viewModel,
      listener: (context,state){
        if(state is AuthLoadingState){
          DialogUtils.showLoading(context: context, message: 'Loading...');
        }else if(state is AuthErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: state.message,
              title: 'Error',posActionName: 'Ok');
        }else if(state is AuthSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: 'Register Successfully',
              title: 'Success',posActionName: 'Ok');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 91.h, bottom: 10.h, left: 97.w, right: 97.w),
                child: Image.asset(
                  AppAssets.appBarLeading,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Full Name",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: false,
                              keyboardType: TextInputType.name,
                              isObscureText: false,
                              hintText: "enter your full name",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: fullNameController,
                              validator: AppValidators.validateFullName,
                            ),
                            Text(
                              "Mobile Number",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.phone,
                                isObscureText: false,
                                hintText: "enter your mobile number",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: phoneController,
                                validator: AppValidators.validatePhoneNumber),
                            Text(
                              "E-mail address",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress,
                                isObscureText: false,
                                hintText: "enter your email address",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: mailController,
                                validator: AppValidators.validateEmail),
                            Text(
                              "Password",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: true,
                              hintText: "enter your password",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: passwordController,
                              validator: AppValidators.validatePassword,
                            ),
                            Text(
                              "RePassword",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: true,
                              hintText: "enter your password again",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: rePasswordController,
                              validator: (value) {
                                return AppValidators.validateConfirmPassword(
                                    value, passwordController.text);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                  backgroundColor: AppColors.whiteColor,
                                  textStyle: AppStyles.semi20Primary,
                                  text: "Sign up",
                                  onPressed: () {
                                    viewModel.register(email: mailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: fullNameController.text,
                                        rePassword: rePasswordController.text);
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.loginRoute);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        'Already have an account? login',
                                        style: AppStyles.medium18White,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\auth\states\auth_states.dart
`dart
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

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\cart_screen\cubit\cart_states.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_cart.dart';

sealed class CartStates{}
class CartInitialState extends CartStates{}
class AddCartLoadingState extends CartStates{}
class AddCartErrorState extends CartStates{
  String message ;
  AddCartErrorState({required this.message});
}
class AddCartSuccessState extends CartStates{
  int numOfCartItems ;
  AddCartSuccessState({required this.numOfCartItems});
}
class GetCartLoadingState extends CartStates{}
class GetCartErrorState extends CartStates{
  String message ;
  GetCartErrorState({required this.message});
}
class GetCartSuccessState extends CartStates{
  GetCart getCart ;
  String? message ;
  GetCartSuccessState({required this.getCart,this.message});
}
class DeleteCartLoadingState extends CartStates{}
class DeleteCartErrorState extends CartStates{
  String message ;
  DeleteCartErrorState({required this.message});
}
class DeleteCartSuccessState extends CartStates{
  GetCart getCart ;
  DeleteCartSuccessState({required this.getCart});
}
class UpdateCartLoadingState extends CartStates{}
class UpdateCartErrorState extends CartStates{
  String message ;
  UpdateCartErrorState({required this.message});
}
class UpdateCartSuccessState extends CartStates{
  GetCart getCart ;
  UpdateCartSuccessState({required this.getCart});
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\cart_screen\cubit\cart_view_model.dart
`dart
import 'package:e_commerce_app/domain/entities/response/get_products.dart';
import 'package:e_commerce_app/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/delete_items_in_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_items_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/update_count_in_cart_use_case.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exception.dart';

@injectable
class CartViewModel extends Cubit<CartStates>{
  AddToCartUseCase addToCartUseCase ;
  GetItemsCartUseCase getItemsCartUseCase ;
  DeleteItemsInCartUseCase deleteItemsInCartUseCase ;
  UpdateCountInCartUseCase updateCountInCartUseCase ;
  CartViewModel({required this.addToCartUseCase,
  required this.getItemsCartUseCase,required this.deleteItemsInCartUseCase,
  required this.updateCountInCartUseCase}):super(CartInitialState());

  int numOfCartItems = 0 ;
  List<GetProducts> productsList = [];

  static CartViewModel get(context) => BlocProvider.of<CartViewModel>(context);


  Future<void> addToCart(String productId)async{
    try{
      emit(AddCartLoadingState());
      var addCartResponse = await addToCartUseCase.invoke(productId);
      numOfCartItems = addCartResponse.numOfCartItems ?? 0 ;
      emit(AddCartSuccessState(numOfCartItems: numOfCartItems));
    }on AppException catch(e){
      emit(AddCartErrorState(message: e.message));
    }
  }
  Future<void> getItemsCart()async{
    try{
      emit(GetCartLoadingState());
      var getCartResponse = await getItemsCartUseCase.invoke();
      numOfCartItems = getCartResponse.numOfCartItems ?? 0 ;
      productsList = getCartResponse.data!.products ?? [];
      emit(GetCartSuccessState(getCart: getCartResponse.data!));
    }on AppException catch(e){
      emit(GetCartErrorState(message: e.message));
    }
  }
  Future<void> deleteCart(String productId)async{
    try{
      var deleteCartResponse = await deleteItemsInCartUseCase.invoke(productId);
      numOfCartItems = deleteCartResponse.numOfCartItems ?? 0 ;
      productsList = deleteCartResponse.data!.products ?? [];
      print('deleted items successfully.');
      emit(GetCartSuccessState(getCart: deleteCartResponse.data!,message: 'Deleted Item Successfully.'));
    }on AppException catch(e){
      emit(DeleteCartErrorState(message: e.message));
    }
  }
  Future<void> updateCart(String productId,int count)async{
    try{
      var updateCartResponse = await updateCountInCartUseCase.invoke(productId,count);
      // numOfCartItems = updateCartResponse.numOfCartItems ?? 0 ;
      productsList = updateCartResponse.data!.products ?? [];
      emit(GetCartSuccessState(getCart: updateCartResponse.data!,message: 'Updated Count Successfully.'));
      print('update count successfully.');
    }on AppException catch(e){
      emit(UpdateCartErrorState(message: e.message));
    }
  }



}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\cart_screen\cart_screen.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/flutter_toast.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/cart_item.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_badge.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "CartItems";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartViewModel.get(context).getItemsCart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _customAppBar(context),
        body: BlocListener<CartViewModel,CartStates>(
          listener: (context, state) {
            if(state is GetCartSuccessState){
              ToastMessage.toastMsg(state.message??'Success',
                  AppColors.greenColor,
                  AppColors.whiteColor
              );
            }
          },
          child: BlocBuilder<CartViewModel,CartStates>(
            builder: (context, state) {
              if(state is GetCartErrorState){
                return MainErrorWidget(errorMessage: state.message);
              }else if(state is GetCartSuccessState){
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: state.getCart.products?.length??0,
                          itemBuilder: (context, index) {
                            return  CartItem(getCart: state.getCart.products![index],);
                          },
                        )),
                    _buildCheckOut(context, state.getCart.totalCartPrice?.toDouble()??0.0),
                  ],
                );
              }else{
                return const MainLoadingWidget();
              }
            },
          ),
        ));
  }

  Widget _buildCheckOut(BuildContext context, double price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h, left: 16.w, right: 16.w),
      child: Row(
        children: [
          Column(
            children: [
              AutoSizeText(
                "Total Price",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 18.sp,
                    ),
              ),
              AutoSizeText(
                "$price",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    //todo: navigate to payment section
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        "Check Out",
                        maxLines: 1,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                        size: 28.sp,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}

PreferredSizeWidget _customAppBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 50.h,
    centerTitle: true,
    elevation: 0,
    title: const Text("Cart"),
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.primaryColor,
    titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor),
    actions: [
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(
          Icons.search_outlined,
          size: 35.sp,
          color: AppColors.primaryColor,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: const CustomAppBarBadge(count: 5),
      ),
    ],
  );
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\cubit\home_screen_states.dart
`dart
abstract class HomeScreenStates{}
class HomeInitialState extends HomeScreenStates{}
class ChangeSelectedIndexState extends HomeScreenStates{}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\cubit\home_screen_view_model.dart
`dart
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../tabs/favorite_tab/favorite_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/products_tab/products_tab.dart';
import '../tabs/user_tab/user_tab.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates>{
  HomeScreenViewModel():super(HomeInitialState());
  //todo: hold data - handle logic
  int selectedIndex = 0;
  List<Widget> bodyList = [
     HomeTab(),
    ProductsTab(),
    FavoriteTab(),
    const UserTab()
  ];
  void bottomNavOnTap(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\favorite_tab\favorite_tab.dart
`dart
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends StatelessWidget {
  List<Map<String, dynamic>> favoriteProducts = [
    {
      "title": "Nike Air Jordon",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 23, 23, 24),
      "imageUrl":
          "https://imgs.search.brave.com/NaDDjSX3QXU-04z5jEIziIY6ww1QLwFnktJ5ZF8RI0A/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzYwLzkyLzIz/LzM2MF9GXzk2MDky/MjMyNV9Renp0emlr/cXllU3dsQWxxUFd5/NkZjSzdpOTRiV2t2/bi5qcGc",
      "salePrice": "1,500"
    },
    {
      "title": "Tall Cotton Dress",
      "finalPrice": "600",
      "color": const Color.fromARGB(255, 233, 123, 20),
      "imageUrl":
          "https://imgs.search.brave.com/NaDDjSX3QXU-04z5jEIziIY6ww1QLwFnktJ5ZF8RI0A/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzYwLzkyLzIz/LzM2MF9GXzk2MDky/MjMyNV9Renp0emlr/cXllU3dsQWxxUFd5/NkZjSzdpOTRiV2t2/bi5qcGc",
      "salePrice": "750"
    },
    {
      "title": "GUESS Womenâ€™s",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 255, 148, 175),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/3fcf/e2de/92c1582f45fdca603f959997bfa35cbe?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QeV-qjdBGetGEiu7uDdauE66Z5yttU6-vWCJ3UP3psaxm8WZyuuchrrkyph01bHIRwwJLn4w28HG5Tsi-UxqVWSbs~yxkZasvbjO93Hu2UN8cKX0XXmSw9Ug7Sm86LB5f2uaqqVk6F~xVr8M8gXfdsNiO8R2VzONaE03OQV~wXhNUSyuFS5s9CPXgtB60Gl8RmAUTKXmFi5V-nxPLjQL6lFYhNcS1-5addo~rCvr4erMQARjSJVdPKHW7eFBycwy7x2r5hRqavDlHfj4wEzzwV6TaQJaOeUN5Q7IvZGKK682CCRBOe6ax2nlf2eQG2vrG33bYxK9DOBKlnHw~p5~qg__",
      "salePrice": "1,500"
    },
    {
      "title": "Nike Air Jordon",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 23, 23, 24),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/a434/c8f5/becb2cf90b140b5af08945a5ee61e536?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NGtU0NXoeog6upzaakLakZTqmtYqrPAxODcxd3YnGEqPFdGbzuk4LL2xwJgNF~kexZPCNkj8aDwUS0T48PU0c7m3dYGK5WnMbrpLFaY3hoMEOubimEnmuelxR-vz~bcoOxHHzmYZ9mp0t6mMfR36Lrk8TSwX5MWATG7YHnZHWQxAoitNCgrpZByo3oqOENpF3tE1R-q~z99FXN3RI~RZ55gL-FKB0MPsu8RLhO1q~P8XSZQQ5j0~P6MAzh2RFKUz1a56yP5wuYCx7edAR12ACAsg8tO7UXneD-LBxaAkyAHoPJbcnmVM9QV3N~7sPbKmd3bTyo3LtJgq9zPMLRHUaw__",
      "salePrice": "1,500"
    },
    {
      "title": "Tall Cotton Dress",
      "finalPrice": "600",
      "color": const Color.fromARGB(255, 233, 123, 20),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/335b/4609/de8eaf66c6e5c2fad29288b1bb0c6ada?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VxLSH2U8OAfQ1yxFPiL9hKbXG67g6yA0tRDLaWlla0gA58KCx94JrIalAu86GQHdymToO4gKUnZBFMosbyiovSL6F2So4QL-UytilX8qDbbrDRldkCKYv55ORm9GRbIbteDzTEUip05lR3047AtBYOtGAJAkQKTSVK6IP9x09-Ie2Wsv2SAdDUouAvPsLVDzi6YFN7Z7tcI7rwD~BN3SA1cz48u8xHcxI8qkQOiIrnvjZIf4G0ahqTy6KMESPuP5fORAyjsD6DRR918-Liy3YuDowNCg8rAt8-8RIFtt01W0CDNTyrwRBAzHsfgwmdlFVaZi7naiT52LGcsbWDhh-g__",
      "salePrice": "750"
    },
    {
      "title": "GUESS Womenâ€™s",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 255, 148, 175),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/3fcf/e2de/92c1582f45fdca603f959997bfa35cbe?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QeV-qjdBGetGEiu7uDdauE66Z5yttU6-vWCJ3UP3psaxm8WZyuuchrrkyph01bHIRwwJLn4w28HG5Tsi-UxqVWSbs~yxkZasvbjO93Hu2UN8cKX0XXmSw9Ug7Sm86LB5f2uaqqVk6F~xVr8M8gXfdsNiO8R2VzONaE03OQV~wXhNUSyuFS5s9CPXgtB60Gl8RmAUTKXmFi5V-nxPLjQL6lFYhNcS1-5addo~rCvr4erMQARjSJVdPKHW7eFBycwy7x2r5hRqavDlHfj4wEzzwV6TaQJaOeUN5Q7IvZGKK682CCRBOe6ax2nlf2eQG2vrG33bYxK9DOBKlnHw~p5~qg__",
      "salePrice": "1,500"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FavoriteItem(
              product: favoriteProducts[index],
            ),
            itemCount: favoriteProducts.length,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildCustomBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50.r));
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\home_tab\cubit\home_tab_states.dart
`dart
import 'package:e_commerce_app/domain/entities/response/category.dart';

sealed class HomeTabStates{}
class HomeTabInitialState extends HomeTabStates{}
class CategoryLoadingState extends HomeTabStates{}
class CategoryErrorState extends HomeTabStates{
  String message ;
  CategoryErrorState({required this.message});
}
// class CategorySuccessState extends HomeTabStates{
//   List<Category>? categoriesList ;
//   CategorySuccessState({required this.categoriesList});
// }
class BrandLoadingState extends HomeTabStates{}
class BrandErrorState extends HomeTabStates{
  String message ;
  BrandErrorState({required this.message});
}
// class BrandSuccessState extends HomeTabStates{
//   List<Category>? brandsList ;
//   BrandSuccessState({required this.brandsList});
// }
class HomeTabSuccessState extends HomeTabStates{
  List<Category>? categoriesList ;
  List<Category>? brandsList ;

  HomeTabSuccessState({this.categoriesList, this.brandsList});

  HomeTabSuccessState copyWith(
      {List<Category>? categoriesList, List<Category>? brandsList}) {
    return HomeTabSuccessState(
        categoriesList: categoriesList ?? this.categoriesList,
        brandsList: brandsList ?? this.brandsList);
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\home_tab\cubit\home_tab_view_model.dart
`dart
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_brands_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeTabViewModel extends Cubit<HomeTabStates>{
  GetAllCategoriesUseCase getAllCategoriesUseCase ;
  GetAllBrandsUseCase getAllBrandsUseCase ;
  HomeTabViewModel({required this.getAllCategoriesUseCase,
  required this.getAllBrandsUseCase}):super(HomeTabInitialState());
  //todo: hold data - handle logic
  List<String> imagesList = [
    AppAssets.announcement1,
    AppAssets.announcement2,
    AppAssets.announcement3,
  ];

  HomeTabSuccessState successState = HomeTabSuccessState();

  Future<void> getCategories()async{
    try{
      emit(CategoryLoadingState());
      var categoriesList = await getAllCategoriesUseCase.invoke();
      emit(successState = successState.copyWith(categoriesList: categoriesList));
    }on AppException catch(e){
      emit(CategoryErrorState(message: e.message));
    }
  }
  Future<void> getBrands()async{
    try{
      emit(BrandLoadingState());
      var brandsList = await getAllBrandsUseCase.invoke();
      emit(successState = successState.copyWith(brandsList: brandsList));
    }on AppException catch(e){
      emit(BrandErrorState(message: e.message));
    }
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\home_tab\home_tab.dart
`dart
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/category_brand_item.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
   HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getCategories();
    viewModel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          _buildAnnouncement(
            images: viewModel.imagesList,
          ),
          SizedBox(
            height: 24.h,
          ),
          _lineBreak(name: "Categories"),
          BlocBuilder<HomeTabViewModel,HomeTabStates>(
            bloc: viewModel,
              builder: (context, state) {
                if(state is CategoryErrorState){
                  return MainErrorWidget(errorMessage: state.message,
                  onTryAgain: (){
                    viewModel.getCategories();
                  },);
                }else if(state is HomeTabSuccessState){
                  return _buildCategoryBrandSec(state.categoriesList??[]);
                }else {
                  //todo: loading
                  return const MainLoadingWidget();
                }
              },
          ),
              // child: _buildCategoryBrandSec(const CategoryBrandItem())),
          _lineBreak(name: "Brands"),
          BlocBuilder<HomeTabViewModel,HomeTabStates>(
            bloc: viewModel,
            builder: (context, state) {
              if(state is BrandErrorState){
                return MainErrorWidget(errorMessage: state.message,
                  onTryAgain: (){
                    viewModel.getCategories();
                  },);
              }else if(state is HomeTabSuccessState){
                return _buildCategoryBrandSec(state.brandsList??[]);
              }else {
                //todo: loading
                return const MainLoadingWidget();
              }
            },
          )
          // _buildCategoryBrandSec(const CategoryBrandItem()),
        ],
      ),
    );
  }

  SizedBox _buildCategoryBrandSec(List<Category> list) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryBrandItem(item: list[index] ,);
        },
      ),
    );
  }

  ImageSlideshow _buildAnnouncement({
    required List<String> images,
  }) {
    return ImageSlideshow(
        indicatorColor: AppColors.primaryColor,
        initialPage: 0,
        indicatorBottomPadding: 15.h,
        indicatorPadding: 8.w,
        indicatorRadius: 5,
        indicatorBackgroundColor: AppColors.whiteColor,
        isLoop: true,
        autoPlayInterval: 3000,
        height: 190.h,
        children: images.map((url) {
          return Image.asset(
            url,
            fit: BoxFit.fill,
          );
        }).toList());
  }

  Widget _lineBreak({required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: AppStyles.medium18Header),
        TextButton(
          onPressed: () {
            //todo: navigate to all
          },
          child: Text("View All", style: AppStyles.regular12Text),
        )
      ],
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\products_tab\cubit\product_tab_states.dart
`dart
import 'package:e_commerce_app/domain/entities/response/product.dart';

sealed class ProductTabStates{}
class ProductTabInitialState extends ProductTabStates{}
class ProductLoadingState extends ProductTabStates{}
class ProductErrorState extends ProductTabStates{
  String message ;
  ProductErrorState({required this.message});
}
class ProductSuccessState extends ProductTabStates{
  List<Product>? productsList ;
  ProductSuccessState({required this.productsList});
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\products_tab\cubit\product_tab_view_model.dart
`dart
import 'package:e_commerce_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductTabViewModel extends Cubit<ProductTabStates>{
  GetAllProductsUseCase getAllProductsUseCase ;
  ProductTabViewModel({required this.getAllProductsUseCase}):super(ProductLoadingState());
  //todo: hold data - handle logic


  Future<void> getProducts()async{
    try{
      emit(ProductLoadingState());
      var productsList = await getAllProductsUseCase.invoke();
      emit(ProductSuccessState(productsList: productsList));
    }on AppException catch(e){
      emit(ProductErrorState(message: e.message));
    }
  }
}

``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\products_tab\products_tab.dart
`dart
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/flutter_toast.dart';

class ProductsTab extends StatefulWidget {
  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  ProductTabViewModel viewModel = getIt<ProductTabViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getProducts();
  }
  // @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartViewModel,CartStates>(
      listener: (context, state) {
        if(state is AddCartSuccessState){
          ToastMessage.toastMsg(
              'Added Item Successfully',
              AppColors.greenColor,
              AppColors.whiteColor);
        }else if(state is AddCartErrorState){
          ToastMessage.toastMsg(
              state.message,
              AppColors.redColor,
              AppColors.whiteColor);
        }
      },
      child: BlocBuilder<ProductTabViewModel,ProductTabStates>(
        bloc: viewModel,
        builder: (context, state) {
          if(state is ProductErrorState){
            return MainErrorWidget(errorMessage: state.message);
          }else if(state is ProductSuccessState){
            return SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.8.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h),
                  itemCount: state.productsList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //todo: navigate to product details screen
                        Navigator.pushNamed(context, AppRoutes.productRoute,
                        arguments: state.productsList![index]);
                      },
                      child:  ProductTabItem(product: state.productsList![index],),
                    );
                  },
                ))
              ],
            ));
          }else{
            return const MainLoadingWidget();
          }
        },

      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\tabs\user_tab\user_tab.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  TextEditingController fullNameController = TextEditingController(text: "Mohamed Mohamed Nabil");
  TextEditingController emailController = TextEditingController(text: "mohamed.N@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "**********");
  TextEditingController mobileController = TextEditingController(text: "01122118855");
  TextEditingController addressController = TextEditingController(text: "6th October, street 11.....");
  bool fullNameReadOnly = true;
  bool emailReadOnly = true;
  bool passwordReadOnly = true;
  bool mobileReadOnly = true;
  bool addressReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Welcome, Mohamed",
                  style: AppStyles.medium18Header,
                ),
                IconButton(onPressed: (){
                  //todo: remove token
                  SharedPrefsUtils.removeData(key: 'token');
                  //todo: navigate to login
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRoute,
                      (route) => false,);
                },
                    icon: Icon(Icons.logout))
              ],
            ),
            AutoSizeText(
              "mohamed.N@gmail.com",
              style: AppStyles.medium14LightPrimary,
            ),
            SizedBox(height: 40.h,),
            AutoSizeText(
              "Your full name",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: fullNameReadOnly,
              keyboardType: TextInputType.name,
              controller: fullNameController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(onPressed: () {
                fullNameReadOnly = false;
                setState(() {});
              }, icon: const Icon(Icons.edit)),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
            AutoSizeText(
              "Your E-mail",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              readonly: emailReadOnly,
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(onPressed: () {
                emailReadOnly = false;
                setState(() {});
              }, icon: const Icon(Icons.edit)),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
            AutoSizeText(
              "Your password",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isObscureText: true,
              readonly: passwordReadOnly,
              isPassword: false,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(onPressed: () {
                passwordReadOnly = false;
                setState(() {});
              }, icon: const Icon(Icons.edit)),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
            AutoSizeText(
              "Your mobile number",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: mobileReadOnly,
              keyboardType: TextInputType.phone,
              controller: mobileController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(onPressed: () {
                mobileReadOnly = false;
                setState(() {});
              }, icon: const Icon(Icons.edit)),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
            AutoSizeText(
              "Your Address",
              style: AppStyles.medium18Header,
            ),
            CustomTextFormField(
              isPassword: false,
              readonly: addressReadOnly,
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              borderColor: AppColors.primary30Opacity,
              suffixIcon: IconButton(onPressed: () {
                addressReadOnly = false;
                setState(() {});
              }, icon: const Icon(Icons.edit)),
              textStyle: AppStyles.medium14PrimaryDark,
            ),
          ],
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\home_screen\home_screen.dart
`dart
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/favorite_tab/favorite_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/home_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/products_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/user_tab/user_tab.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_badge.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartViewModel.get(context).getItemsCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel,HomeScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(viewModel.selectedIndex),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child:viewModel. bodyList[viewModel.selectedIndex],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                currentIndex: viewModel.selectedIndex,
                onTap: viewModel.bottomNavOnTap,
                iconSize: 24.sp, // Adjust the icon size
                items: [
                  _bottomNavBarItemBuilder(
                    isSelected:viewModel. selectedIndex == 0,
                    selectedIcon: AppAssets.selectedHomeIcon,
                    unselectedIcon: AppAssets.unSelectedHomeIcon,
                  ),
                  _bottomNavBarItemBuilder(
                    isSelected: viewModel.selectedIndex == 1,
                    selectedIcon: AppAssets.selectedCategoryIcon,
                    unselectedIcon: AppAssets.unSelectedCategoryIcon,
                  ),
                  _bottomNavBarItemBuilder(
                    isSelected: viewModel.selectedIndex == 2,
                    selectedIcon: AppAssets.selectedFavouriteIcon,
                    unselectedIcon: AppAssets.unSelectedFavouriteIcon,
                  ),
                  _bottomNavBarItemBuilder(
                    isSelected: viewModel.selectedIndex == 3,
                    selectedIcon: AppAssets.selectedAccountIcon,
                    unselectedIcon: AppAssets.unSelectedAccountIcon,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavBarItemBuilder(
      {required bool isSelected,
      required String selectedIcon,
      required String unselectedIcon}) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        foregroundColor:
            isSelected ? AppColors.primaryColor : AppColors.whiteColor,
        backgroundColor: isSelected ? AppColors.whiteColor : Colors.transparent,
        radius: 25.r,
        child: Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
        ),
      ),
      label: "",
    );
  }

  OutlineInputBorder _buildCustomBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50.r));
  }

  PreferredSizeWidget _buildAppBar(int index) {
    return AppBar(
      surfaceTintColor: AppColors.transparentColor,
      elevation: 0,
      toolbarHeight: index != 3 ? 120.h : kToolbarHeight,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Image.asset(
                AppAssets.routeLogo,
                width: 66.w,
                height: 22.h,
              ),
            ),
            Visibility(
              visible: index != 3,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          style: AppStyles.regular14Text,
                          cursorColor: AppColors.primaryColor,
                          onTap: () {
                            //todo: implement search logic
                          },
                          decoration: InputDecoration(
                              border: _buildCustomBorder(),
                              enabledBorder: _buildCustomBorder(),
                              focusedBorder: _buildCustomBorder(),
                              contentPadding: EdgeInsets.all(16.h),
                              hintStyle: AppStyles.light14SearchHint,
                              hintText: "what do you search for?",
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30.sp,
                                color: AppColors.primaryColor.withOpacity(0.75),
                              ))),
                    ),
                    const CustomAppBarBadge(count: 5)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\pages\product_details_screen\product_details_screen.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/features/ui/widgets/product_tab_item.dart';
import 'package:e_commerce_app/features/ui/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int productCounter = 0;
  int selectedColor = 0;
  int selectedSize = 0;
  double totalPrice = 0;

  List<int> sizes = [35, 38, 39, 40];
  List<Color> color = [
    Colors.red,
    Colors.blueAccent,
    Colors.green,
    Colors.yellow,
  ];

  List<String> productImages = [
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
  ];

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Product ;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: AppStyles.semi20Primary,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primaryColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSlider(
                initialIndex: 0,
                items: product.images! ,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.title??'',
                      style: AppStyles.medium18Header,
                    ),
                  ),
                  Text(
                    "EGP ${product.price}",
                    style: AppStyles.medium18Header,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor.withOpacity(.3),
                          width: 1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      '${product.sold} Sold',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.medium14PrimaryDark,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Image.asset(
                    AppAssets.starIcon,
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(
                      "${product.ratingsAverage} (${product.ratingsQuantity})",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular14Text,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (productCounter != 0) {
                                productCounter--;
                                //todo: get unit price first
                                // assuming unit price is 500
                                totalPrice -= 500;
                                setState(() {});
                              }
                            },
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 20.w,
                              color: AppColors.whiteColor,
                            )),
                        SizedBox(
                          width: 18.w,
                        ),
                        AutoSizeText(
                          '$productCounter',
                          style: AppStyles.medium18White,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        InkWell(
                            onTap: () {
                              productCounter++;
                              //todo: get unit price first
                              // assuming unit price is 500
                              totalPrice += 500;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.whiteColor,
                              size: 20.w,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Description',
                style: AppStyles.medium18Header,
              ),
              SizedBox(
                height: 8.h,
              ),
              ReadMoreText(
                product.description??'',
                style: AppStyles.medium14LightPrimary,
                trimExpandedText: ' Read Less',
                trimCollapsedText: ' Read More',
                trimLines: 2,
                trimMode: TrimMode.Line,
                colorClickableText: AppColors.primaryColor,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text('Size', style: AppStyles.medium18Header),
              _buildSizeSection(),
              Text('Color', style: AppStyles.medium18Header),
              _buildColorSection(),
              _buildPriceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = index;
                });
              },
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: color[index],
                child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: index == selectedSize
                          ? AppColors.whiteColor
                          : Colors.transparent,
                    )),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 17.w,
              ),
          itemCount: color.length),
    );
  }

  Widget _buildSizeSection() {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: index == selectedColor
                    ? AppColors.primaryColor
                    : Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                  child: Text(
                    '${sizes[index]}',
                    style: AppStyles.regular14Text.copyWith(
                        color: index == selectedColor
                            ? AppColors.whiteColor
                            : AppColors.primaryColor),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 17.w,
              ),
          itemCount: sizes.length),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      margin: EdgeInsets.only(top: 48.h),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Total price',
                style: AppStyles.medium18Header
                    .copyWith(color: AppColors.primaryDark.withOpacity(0.6)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("EGP $totalPrice", style: AppStyles.medium18Header)
            ],
          ),
          SizedBox(
            width: 33.w,
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.r)),
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_shopping_cart,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    AutoSizeText("Add To Cart", style: AppStyles.medium20White),
                  ],
                )),
          )
        ],
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\cart_item.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart.dart';
import 'package:e_commerce_app/domain/entities/response/get_products.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatefulWidget {
  GetProducts getCart ;
   CartItem({super.key,required this.getCart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo: navigate to product detail screen
        Navigator.pushNamed(context, AppRoutes.productRoute);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Container(
          height: 142.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.primary30Opacity, width: 1),
          ),
          child: Row(
            children: [
              _buildImageContainer(imageCover:widget.getCart.product?.imageCover??'' ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  child: Column(
                    children: [
                      _buildItemHeader(title: widget.getCart.product?.title??'',
                      productId: widget.getCart.product?.id??''),
                      SizedBox(height: 5.h),
                      _buildItemDetails(),
                      SizedBox(height: 5.h),
                      _buildItemPrice(price: widget.getCart.price?.toDouble()??0.0,
                      count: widget.getCart.count!,
                      onPressedIncrement: (){
                        int count = widget.getCart.count! ;
                        count++ ;
                        setState(() {

                        });
                        CartViewModel.get(context).updateCart(widget.getCart.product?.id??'',
                         count);
                      },
                      onPressedDecrement: (){
                        int count = widget.getCart.count! ;
                        if(count > 1) {
                          count--;
                        }
                        setState(() {

                        });
                        CartViewModel.get(context).updateCart(widget.getCart.product?.id??'',
                            count);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer({required String imageCover}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary30Opacity, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: CachedNetworkImage(
          width: 130.w,
          height: 145.h,
          fit: BoxFit.cover,
          imageUrl:imageCover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }

  Widget _buildItemHeader({required String title,required String productId}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
          ),
        ),
        InkWell(
          onTap: () {
            // TODO: delete item from cart
            CartViewModel.get(context).deleteCart(productId);
          },
          child: Icon(
            CupertinoIcons.delete,
            color: AppColors.primaryColor,
            size: 25.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildItemDetails() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.blackColor,
          radius: 10.r,
        ),
        SizedBox(width: 10.w),
        AutoSizeText(
          "black | size 40",
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryDarkLight,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }

  Widget _buildItemPrice({required double price,
    required int count,required VoidCallback onPressedIncrement,
    required VoidCallback onPressedDecrement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          "Egp $price",
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
        ),
        _buildQuantityControl(
          count: count,
          onPressedDecrement:onPressedDecrement ,
          onPressedIncrement: onPressedIncrement
        ),
      ],
    );
  }

  Widget _buildQuantityControl({required int count,required VoidCallback onPressedIncrement,
  required VoidCallback onPressedDecrement}) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onPressedDecrement,
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: AppColors.whiteColor,
              size: 25.sp,
            ),
          ),
          AutoSizeText(
            "$count",
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
          IconButton(
            onPressed: onPressedIncrement,
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.whiteColor,
              size: 25.sp,
            ),
          ),
        ],
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\category_brand_item.dart
`dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBrandItem extends StatelessWidget {
  final Category item ;
  const CategoryBrandItem({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: CachedNetworkImage(
              width: double.infinity,
              height: 10.h,
              fit: BoxFit.cover,
              imageUrl: item.image??"",
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 50.r,
                );
              },
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryDark,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.redColor,
              ),
            )),
        SizedBox(
          height: 8.h,
        ),
        Expanded(
            flex: 4,
            child: Text(
              item.name??'',
              textWidthBasis: TextWidthBasis.longestLine,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
            ))
      ],
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\custom_badge.dart
`dart
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarBadge extends StatelessWidget {
  final int count;

  const CustomAppBarBadge({required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return InkWell(
      onTap: currentRoute != AppRoutes.cartRoute
          ? () {
              Navigator.of(context).pushNamed(AppRoutes.cartRoute);
            }
          : null,
      child: BlocBuilder<CartViewModel,CartStates>(
        builder: (context, state) {
          final viewModel = CartViewModel.get(context);
          return Badge(
            alignment: AlignmentDirectional.topStart,
            backgroundColor: AppColors.greenColor,
            label: Text(viewModel.numOfCartItems.toString()),
            child: ImageIcon(
              const AssetImage(AppAssets.shoppingCart),
              size: 35.sp,
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\custom_elevated_button.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  Color backgroundColor;
  TextStyle textStyle;
  void Function()? onPressed;
  CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
      ),
      child: SizedBox(
        height: 64.h,
        width: 398.w,
        child: Center(
          child: AutoSizeText(text, style: textStyle),
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\custom_text_form_field.dart
`dart
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  Color? filledColor;
  Color borderColor;
  TextStyle? hintStyle;
  String? hintText;
  Widget? label;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  bool isObscureText;
  bool isPassword;
  TextStyle? textStyle;
  bool  readonly;

  CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.label,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscureText = false,
    this.isPassword = false,
    this.filledColor = AppColors.whiteColor,
    this.keyboardType = TextInputType.text,
    this.borderColor = AppColors.whiteColor,
    this.readonly = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
      child: TextFormField(
        style: widget.textStyle,
        obscureText: widget.isObscureText,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        readOnly: widget.readonly,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.filledColor,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.label,
          labelStyle: widget.labelStyle,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    widget.isObscureText = !widget.isObscureText;
                    setState(() {});
                  },
                  icon: Icon(widget.isObscureText
                      ? Icons.visibility_off
                      : Icons.visibility))
              : widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: widget.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: widget.borderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.redColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.redColor)),
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\favorite_item.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:colornames/colornames.dart';

class FavoriteItem extends StatefulWidget {
  final Map<String, dynamic> product;
  String heartIcon = AppAssets.selectedFavouriteIcon;
  bool isClicked = false;

  FavoriteItem({super.key, required this.product});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.productRoute);
        },
        child: Container(
          height: 135.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(.6),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    width: 120.w,
                    height: 135.h,
                    fit: BoxFit.cover,
                    imageUrl: widget.product["imageUrl"],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w, bottom: 8.h, left: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            widget.product["title"],
                            style: AppStyles.medium18Header,
                          ),
                          InkWell(
                            // radius: 25,
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onTap: () {
                              setState(() {
                                widget.isClicked = !widget.isClicked;
                                widget.heartIcon = !widget.isClicked
                                    ? AppAssets.selectedFavouriteIcon
                                    : AppAssets.selectedAddToFavouriteIcon;
                              });
                            },
                            child: Material(
                              // borderRadius: BorderRadius.circular(2),
                              color: AppColors.whiteColor,
                              elevation: 5,
                              shape: const StadiumBorder(),
                              shadowColor: AppColors.blackColor,
                              child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: ImageIcon(
                                    AssetImage(widget.heartIcon),
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            width: 14.w,
                            height: 14.h,
                            decoration: BoxDecoration(
                              color: widget.product["color"],
                              shape: BoxShape.circle,
                            ),
                          ),
                          AutoSizeText(
                            (widget.product["color"] as Color).colorName,
                            style: AppStyles.regular14Text,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "EGP ${widget.product["finalPrice"]}",
                            style: AppStyles.medium18Header,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          AutoSizeText(
                            "EGP${widget.product["salePrice"]}",
                            style: AppStyles.regular11SalePrice.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 100.w,
                            height: 36.h,
                            child: CustomElevatedButton(
                                text: "Add To Cart",
                                onPressed: () {},
                                backgroundColor: AppColors.primaryColor,
                                textStyle: AppStyles.medium14Category
                                    .copyWith(color: AppColors.whiteColor)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\main_error_widget.dart
`dart
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  final VoidCallback? onTryAgain ;
  const MainErrorWidget({super.key,required this.errorMessage,
  this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(errorMessage,
        style: AppStyles.medium14PrimaryDark,),
        onTryAgain != null ?
        ElevatedButton(onPressed: onTryAgain,
            child: Text('Try Again',
              style: AppStyles.medium14PrimaryDark,)):
            Container()
      ],
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\main_loading_widget.dart
`dart
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\product_slider.dart
`dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductSlider extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  const ProductSlider(
      {super.key, required this.initialIndex, required this.items});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ImageSlideshow(
          onPageChanged: (value) {
            currentIndex = value;
            setState(() {});
          },
          indicatorColor: AppColors.transparentColor,
          initialPage: currentIndex,
          indicatorBackgroundColor: AppColors.transparentColor,
          isLoop: true,
          autoPlayInterval: 3000,
          height: 300.h,
          children: widget.items.map((url) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border:
                      Border.all(color: AppColors.primary30Opacity, width: 1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.cover,
                  imageUrl: url,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.redColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Positioned(
            top: 8.h,
            right: 8.w,
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    spreadRadius: 1,
                    blurRadius: 14,
                    offset: const Offset(0, 7), // Shadow position
                  ),
                ],
              ),
              child: IconButton(
                  onPressed: () {
                    // todo add to favorite
                  },
                  color: AppColors.primaryColor,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                  )),
            )),
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.items.length,
            duration: const Duration(microseconds: 0),
            effect: ExpandingDotsEffect(
              dotWidth: 7.w,
              dotHeight: 7.h,
              dotColor: Colors.grey.shade400,
              paintStyle: PaintingStyle.fill,
              activeDotColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\features\ui\widgets\product_tab_item.dart
`dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/flutter_toast.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTabItem extends StatelessWidget {
  final Product product ;
  const ProductTabItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary30Opacity, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  width: 191.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  imageUrl:product.imageCover??'',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.redColor,
                  ),
                ),
              ),
              Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.whiteColor,
                    radius: 20.r,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            // todo add to favorite
                          },
                          color: AppColors.primaryColor,
                          padding: EdgeInsets.zero,
                          iconSize: 30.r, // Adjust icon size as needed
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            color: AppColors.primaryColor,
                          )),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  product.title??'',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(children: [
                  AutoSizeText(
                    "EGP ${product.price}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  AutoSizeText(
                    "EGP ${product.price!*2}",
                    maxLines: 1,
                    style: AppStyles.regular11SalePrice.copyWith(
                        color: AppColors.discountTextColor,
                        decoration: TextDecoration.lineThrough),
                  ),
                ]),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "Review (${product.ratingsAverage})",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                      size: 25.sp,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        //   todo add to cart
                        CartViewModel.get(context).addToCart(product.id??'');
                      },
                      splashColor: Colors.transparent,
                      child: Icon(
                        Icons.add_circle,
                        size: 32.sp,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


``n
### File: D:\FlutterProjects\e_commerce_sun_c15\lib\main.dart
`dart
import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/config/my_bloc_observer.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/core/utils/app_theme.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/auth/login/login_screen.dart';
import 'package:e_commerce_app/features/ui/auth/register/register_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/home_screen.dart';
import 'package:e_commerce_app/features/ui/pages/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  await SharedPrefsUtils.init();
  String routeName ;
  var token = SharedPrefsUtils.getData(key: 'token');
  if(token == null){
    //todo: no user , no token => login
    routeName = AppRoutes.loginRoute ;
  }else{
    //todo: user => token => home screen
    routeName = AppRoutes.homeRoute ;
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<CartViewModel>(),)
    ],
      child: MyApp(routeName: routeName,)));
}

class MyApp extends StatelessWidget {
  String routeName ;
  MyApp({required this.routeName});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: routeName,
          routes: {
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            AppRoutes.homeRoute: (context) => const HomeScreen(),
            AppRoutes.cartRoute: (context) => const CartScreen(),
            AppRoutes.productRoute: (context) => ProductDetailsScreen(),
          },
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}


``n
