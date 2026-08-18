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
  Future<ProductResponseDto> getAllProducts({
    @Query('category') String? categoryId,
    @Query('brand') String? brandId,
  });
  
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
