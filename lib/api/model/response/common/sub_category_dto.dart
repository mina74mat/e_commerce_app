import 'package:json_annotation/json_annotation.dart';
part 'sub_category_dto.g.dart';
@JsonSerializable()
class SubcategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "category")
  final String? category;

  SubcategoryDto ({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  factory SubcategoryDto.fromJson(Map<String, dynamic> json) {
    return _$SubcategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubcategoryDtoToJson(this);
  }
}