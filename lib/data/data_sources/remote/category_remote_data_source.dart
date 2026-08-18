import 'package:e_commerce_app/domain/entities/response/category.dart';

abstract class CategoryRemoteDataSource{
 Future<List<Category>?> getAllCategories();
}