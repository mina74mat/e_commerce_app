import 'package:e_commerce_app/api/model/response/common/sub_category_dto.dart';
import 'package:e_commerce_app/domain/entities/response/sub_category.dart';

extension SubcategoryMapper on SubcategoryDto{
 Subcategory toSubCategory(){
    return Subcategory(
      name: name,
      slug: slug,
      id: id,
      category: category
    );
  }
}