// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';

part 'cart_entity.g.dart';

@JsonSerializable()
class CartEntity {
  @JsonKey()
  int idUser;
  @JsonKey()
  ProductEntity productEntity;
  @JsonKey()
  String image;
  @JsonKey()
  String description;
  @JsonKey()
  int totalPrice;
  @JsonKey()
  int quantity;

  CartEntity(
      this.idUser, this.productEntity, this.image,
      this.description, this.totalPrice, this.quantity);

  factory CartEntity.fromJson(Map<String, dynamic> json) =>
      _$CartEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
