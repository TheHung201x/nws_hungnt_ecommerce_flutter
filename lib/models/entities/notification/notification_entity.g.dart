// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      idUser: json['idUser'] as int? ?? 0,
      image: json['image'] as String? ?? "",
      title: json['title'] as String? ?? "",
      createAt: json['createAt'] as String? ?? "",
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'image': instance.image,
      'title': instance.title,
      'createAt': instance.createAt,
    };
