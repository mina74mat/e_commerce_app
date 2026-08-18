
import 'package:e_commerce_app/domain/entities/response/add_product.dart';

class AddCart {
  final String? id;
  final String? cartOwner;
  final List<AddProduct>? products;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final int? totalCartPrice;

  AddCart ({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });
}