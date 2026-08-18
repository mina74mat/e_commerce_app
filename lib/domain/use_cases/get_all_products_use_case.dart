import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/domain/repositories/brands/brand_repository.dart';
import 'package:e_commerce_app/domain/repositories/category/category_repository.dart';
import 'package:e_commerce_app/domain/repositories/products/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase{
  ProductRepository productRepository ;
  GetAllProductsUseCase({required this.productRepository});

  Future<List<Product>?>invoke({String? categoryId, String? brandId}){
    return productRepository.getAllProducts(categoryId: categoryId, brandId: brandId);
  }
}