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