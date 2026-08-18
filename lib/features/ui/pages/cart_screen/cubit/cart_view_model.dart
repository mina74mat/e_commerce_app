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