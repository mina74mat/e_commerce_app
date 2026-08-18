import 'package:e_commerce_app/api/model/response/common/category_dto.dart';
import 'package:e_commerce_app/api/model/response/common/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'brand_response_dto.g.dart';

@JsonSerializable()
class BrandResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryDto>? data;

  BrandResponseDto ({
    this.results,
    this.metadata,
    this.data,
  });

  factory BrandResponseDto.fromJson(Map<String, dynamic> json) {
    return _$BrandResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandResponseDtoToJson(this);
  }
}



