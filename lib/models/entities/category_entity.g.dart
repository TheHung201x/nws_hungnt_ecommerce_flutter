// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      image: json['image'] as String? ?? "",
      totalProduct: json['totalProduct'] as int? ?? 0,
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'totalProduct': instance.totalProduct,
    };
