import 'package:e_commerce_app/api/mapper/category_mapper.dart';
import 'package:e_commerce_app/api/mapper/subcategory_mapper.dart';
import 'package:e_commerce_app/api/model/response/common/product_dto.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';

extension ProductMapper on ProductDto{
 Product toProduct(){
    return Product(
      id: id,
      slug: slug,
      category: category!.toCategory(),
      title: title,
      description: description,
      brand: brand!.toCategory(),
      imageCover: imageCover,
      images: images,
      price: price,
      quantity: quantity,
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
      sold: sold,
      subcategory: subcategory?.map((subcategory)=>subcategory.toSubCategory()).toList()??[]
    );
  }
}