import 'package:e_commerce_app/api/model/response/cart/get_cart/get_products_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_cart_dto.g.dart';
@JsonSerializable()
class GetCartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "cartOwner")
  final String? cartOwner;
  @JsonKey(name: "products")
  final List<GetProductsDto>? products;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "totalCartPrice")
  final int? totalCartPrice;

  GetCartDto ({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  factory GetCartDto.fromJson(Map<String, dynamic> json) {
    return _$GetCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetCartDtoToJson(this);
  }
}