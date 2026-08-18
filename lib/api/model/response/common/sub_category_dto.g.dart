// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryDto _$SubcategoryDtoFromJson(Map<String, dynamic> json) =>
    SubcategoryDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$SubcategoryDtoToJson(SubcategoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'category': instance.category,
    };
