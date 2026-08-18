import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';

extension CategoryMapper on CategoryDto{
 Category toCategory(){
    return Category(
      name: name,
      slug: slug,
      id: id,
      image: image
    );
  }
}