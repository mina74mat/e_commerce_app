import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase{
  CategoryRepository categoryRepository ;
  GetAllCategoriesUseCase({required this.categoryRepository});

  Future<List<Category>?>invoke(){
    return categoryRepository.getAllCategories();
  }
}