import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/api/model/response/common/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryDto>? data;

  CategoryResponseDto ({
    this.results,
    this.metadata,
    this.data,
  });

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryResponseDtoToJson(this);
  }
}






