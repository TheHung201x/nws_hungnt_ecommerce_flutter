// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageEntity _$LanguageEntityFromJson(Map<String, dynamic> json) =>
    LanguageEntity(
      locale: json['locale'] as String? ?? "",
      languageCode: json['languageCode'],
    );

Map<String, dynamic> _$LanguageEntityToJson(LanguageEntity instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'languageCode': instance.languageCode,
    };
