// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandResponseDto _$BrandResponseDtoFromJson(Map<String, dynamic> json) =>
    BrandResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandResponseDtoToJson(BrandResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };
