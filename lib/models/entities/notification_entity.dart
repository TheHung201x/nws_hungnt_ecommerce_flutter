import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey()
  String image;
  @JsonKey()
  String title;
  @JsonKey()
  String createAt;

  NotificationEntity({
    this.image = "",
    this.title = "",
    this.createAt = "",
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}