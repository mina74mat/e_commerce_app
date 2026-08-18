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