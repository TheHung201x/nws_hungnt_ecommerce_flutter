import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';

abstract class NotificationRepository {
  Future<String> addToNotification({required NotificationEntity notificationEntity});

  Future<List<NotificationEntity>> getAllNotifications(UserEntity userEntity);
}

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<String> addToNotification({required NotificationEntity notificationEntity}) async {
    final CollectionReference notificationCollection =
    FirebaseFirestore.instance.collection('Notification');
    try {
      await notificationCollection
          .add(notificationEntity.toJson())
          .then((value) => print("Notification Added"))
          .catchError((error) => print("Failed to add Notification: $error"));
      return '200';
    } catch (e) {
      return 'lỗi: $e';
    }
  }

  @override
  Future<List<NotificationEntity>> getAllNotifications(UserEntity userEntity) async {
    final db = FirebaseFirestore.instance;
    List<NotificationEntity> notificationList = [];
    await Future.delayed(const Duration(seconds: 2));
    await db.collection("Notification").where('idUser', isEqualTo: 0).get().then(
          (querySnapshot) {
        querySnapshot.docs.map(
              (e) {
            final notification = NotificationEntity.fromJson(e.data());
            notificationList.add(notification);
          },
        ).toList();
      },
    );

    return notificationList;
  }
}
