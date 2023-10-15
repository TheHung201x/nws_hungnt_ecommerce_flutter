// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  @JsonKey()
  int id;
  @JsonKey()
  String name;
  @JsonKey()
  String image;
  @JsonKey()
  int totalProduct;

  CategoryEntity({
    this.id = 0,
    this.name = "",
    this.image = "",
    this.totalProduct = 0,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
