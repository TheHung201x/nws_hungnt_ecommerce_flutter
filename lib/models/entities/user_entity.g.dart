// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      email: json['email'] as String? ?? "",
      password: json['password'] as String? ?? "",
      name: json['name'] as String? ?? "",
      avatar: json['avatar'] as String? ?? "",
      role: json['role'] as String? ?? "",
      id: json['id'] as int? ?? 0,
      creationAt: json['creationAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'avatar': instance.avatar,
      'role': instance.role,
      'id': instance.id,
      'creationAt': instance.creationAt,
      'updatedAt': instance.updatedAt,
    };
