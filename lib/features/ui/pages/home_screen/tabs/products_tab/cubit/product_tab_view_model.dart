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


  Future<void> getProducts({String? categoryId, String? brandId})async{
    try{
      emit(ProductLoadingState());
      
      // Special handling for merged Fashion category
      // If we want to show all fashion, we might need a different logic,
      // but for now let's ensure the category fetch is correct.

      var productsList = await getAllProductsUseCase.invoke(
          categoryId: categoryId,
          brandId: brandId
      );
      emit(ProductSuccessState(productsList: productsList));
    }on AppException catch(e){
      emit(ProductErrorState(message: e.message));
    }
  }
}