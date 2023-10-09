import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey()
  String email;
  @JsonKey()
  String password;
  @JsonKey()
  String name;
  @JsonKey()
  String avatar;
  @JsonKey()
  String role;
  @JsonKey()
  int id;
  @JsonKey()
  String creationAt;
  @JsonKey()
  String updatedAt;

  UserEntity({
    this.email = "",
    this.password = "",
    this.name = "",
    this.avatar = "",
    this.role = "",
    this.id = 0,
    this.creationAt = "",
    this.updatedAt = "",
  });

  factory UserEntity.updateProfile({required UserEntity userEntity}) {
    return userEntity;
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
