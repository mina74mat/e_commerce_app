
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






