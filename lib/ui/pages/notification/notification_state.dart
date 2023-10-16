part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final LoadStatus addNewNotificationStatus;
  final LoadStatus getAllNotificationsStatus;
  final List<NotificationEntity> notificationList;

  const NotificationState({
    this.addNewNotificationStatus = LoadStatus.initial,
    this.getAllNotificationsStatus = LoadStatus.initial,
    this.notificationList = const [],
  });

  NotificationState copyWith({
    LoadStatus? addNewNotificationStatus,
    LoadStatus? getAllNotificationsStatus,
    List<NotificationEntity>? notificationList,
  }) {
    return NotificationState(
      addNewNotificationStatus:
          addNewNotificationStatus ?? this.addNewNotificationStatus,
      getAllNotificationsStatus:
          getAllNotificationsStatus ?? this.getAllNotificationsStatus,
      notificationList: notificationList ?? this.notificationList,
    );
  }

  @override
  List<Object?> get props =>
      [addNewNotificationStatus, getAllNotificationsStatus, notificationList];
}
