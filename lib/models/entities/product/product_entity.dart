// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  @JsonKey()
  int id;
  @JsonKey()
  String title;
  @JsonKey()
  int price;
  @JsonKey()
  String description;
  @JsonKey()
  List<String> images;

  ProductEntity({
    this.id = 0,
    this.title = "",
    this.price = 0,
    this.description = "",
    this.images = const [],
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
