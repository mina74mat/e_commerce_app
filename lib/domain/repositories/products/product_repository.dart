import 'package:e_commerce_app/domain/entities/response/product.dart';

abstract class ProductRepository{
  Future<List<Product>?> getAllProducts({String? categoryId, String? brandId});
}