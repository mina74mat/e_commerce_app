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