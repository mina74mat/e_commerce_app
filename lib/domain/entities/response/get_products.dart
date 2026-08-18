import 'package:e_commerce_app/domain/entities/response/product.dart';

class GetProducts {
  final int? count;
  final String? id;
  final Product? product;
  final int? price;

  GetProducts ({
    this.count,
    this.id,
    this.product,
    this.price,
  });

}