// ignore: depend_on_referenced_packages
import 'package:ecommerce/configs/app_configs.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'language_entity.g.dart';

@JsonSerializable()
class LanguageEntity {
  @JsonKey()
  String locale;
  @JsonKey()
  Locale languageCode;

  LanguageEntity({
    this.locale = "",
    this.languageCode = AppConfigs.defaultLocal,
  });

  factory LanguageEntity.fromJson(Map<String, dynamic> json) =>
      _$LanguageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageEntityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
