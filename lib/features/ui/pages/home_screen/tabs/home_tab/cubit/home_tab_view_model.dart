import 'package:e_commerce_app/domain/entities/response/category.dart';
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
      
      // Filter and Merge categories as requested
      List<Category> filteredCategories = [];
      
      // Target slugs: home, men's-fashion, women's-fashion, supermarket, electronics, beauty-and-health, baby-and-toys
      Category? fashion;
      Category? home;
      Category? supermarket;
      Category? electronics;
      Category? pharmacy;
      Category? baby;

      for(var cat in categoriesList ?? []) {
        String slug = cat.slug?.toLowerCase() ?? "";
        // Route API Slugs:
        if (slug.contains("home")) home = cat;
        else if (slug.contains("women") && slug.contains("fashion")) fashion = cat; 
        else if (slug.contains("supermarket")) supermarket = cat;
        else if (slug.contains("electronics")) electronics = cat;
        else if (slug.contains("beauty")) pharmacy = cat;
        else if (slug.contains("baby")) baby = cat;
      }

      // If fashion still null, try any fashion
      if (fashion == null) {
        fashion = (categoriesList ?? []).firstWhere(
                (e) => e.slug!.toLowerCase().contains("fashion"),
            orElse: () => Category()
        );
      }

      if(home != null && home.id != null) {
        filteredCategories.add(Category(
            id: home.id,
            name: "Home",
            slug: home.slug,
            image: home.image
        ));
      }
      if(fashion != null && fashion.id != null) {
        filteredCategories.add(Category(
          id: fashion.id,
          name: "Fashion",
          slug: fashion.slug,
          image: fashion.image
        ));
      }
      if(supermarket != null && supermarket.id != null) {
        filteredCategories.add(Category(
            id: supermarket.id,
            name: "Supermarket",
            slug: supermarket.slug,
            image: supermarket.image
        ));
      }
      if(electronics != null && electronics.id != null) {
        filteredCategories.add(Category(
            id: electronics.id,
            name: "Electronics",
            slug: electronics.slug,
            image: electronics.image
        ));
      }
      if(pharmacy != null && pharmacy.id != null) {
        filteredCategories.add(Category(
          id: pharmacy.id,
          name: "Pharmacy",
          slug: pharmacy.slug,
          image: pharmacy.image
        ));
      }
      if(baby != null && baby.id != null) {
        filteredCategories.add(Category(
            id: baby.id,
            name: "Baby & Toys",
            slug: baby.slug,
            image: baby.image
        ));
      }
      
      // If we don't have 6, add whatever is left until we reach 6
      if(filteredCategories.length < 6) {
        for(var cat in categoriesList ?? []) {
          if(!filteredCategories.any((element) => element.id == cat.id)) {
            filteredCategories.add(cat);
          }
          if(filteredCategories.length == 6) break;
        }
      }

      emit(successState = successState.copyWith(categoriesList: filteredCategories.take(6).toList()));
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