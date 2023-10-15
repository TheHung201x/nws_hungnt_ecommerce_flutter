// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'cart_entity.g.dart';

@JsonSerializable()
class CartEntity {
  @JsonKey()
  int id;
  @JsonKey()
  int idUser;
  @JsonKey()
  int idProduct;
  @JsonKey()
  String imageProduct;
  @JsonKey()
  String nameProduct;
  @JsonKey()
  String description;
  @JsonKey()
  double totalPrice;
  @JsonKey()
  int quantity;

  CartEntity(
      {
        this.id = 0,
        this.idUser = 0,
        this.idProduct = 0,
        this.imageProduct = "",
        this.nameProduct = "",
        this.description = "",
        this.totalPrice = 0,
        this.quantity = 0,
      });

  factory CartEntity.fromJson(Map<String, dynamic> json) =>
      _$CartEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}
