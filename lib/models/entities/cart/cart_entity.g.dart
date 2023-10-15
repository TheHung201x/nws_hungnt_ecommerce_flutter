// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) => CartEntity(
      id: json['id'] as int? ?? 0,
      idUser: json['idUser'] as int? ?? 0,
      idProduct: json['idProduct'] as int? ?? 0,
      imageProduct: json['imageProduct'] as String? ?? "",
      nameProduct: json['nameProduct'] as String? ?? "",
      description: json['description'] as String? ?? "",
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idUser': instance.idUser,
      'idProduct': instance.idProduct,
      'imageProduct': instance.imageProduct,
      'nameProduct': instance.nameProduct,
      'description': instance.description,
      'totalPrice': instance.totalPrice,
      'quantity': instance.quantity,
    };
