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