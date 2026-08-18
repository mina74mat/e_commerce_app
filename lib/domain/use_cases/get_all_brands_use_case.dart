import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllBrandsUseCase{
  BrandRepository brandRepository ;
  GetAllBrandsUseCase({required this.brandRepository});

  Future<List<Category>?>invoke(){
    return brandRepository.getAllBrands();
  }
}