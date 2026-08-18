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