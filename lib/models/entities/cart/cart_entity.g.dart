// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) => CartEntity(
      json['idUser'] as int,
      ProductEntity.fromJson(json['productEntity'] as Map<String, dynamic>),
      json['image'] as String,
      json['totalPrice'] as int,
      json['quantity'] as int,
    );

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'productEntity': instance.productEntity.toJson(),
      'image': instance.image,
      'totalPrice': instance.totalPrice,
      'quantity': instance.quantity,
    };
