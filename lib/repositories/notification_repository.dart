import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:flutter/foundation.dart';

abstract class NotificationRepository {
  Future<String> addToNotification(
      {required NotificationEntity notificationEntity});

  Future<List<NotificationEntity>> getAllNotifications(int id);
}

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<String> addToNotification(
      {required NotificationEntity notificationEntity}) async {
    final CollectionReference notificationCollection =
        FirebaseFirestore.instance.collection('Notification');
    try {
      await notificationCollection
          .add(notificationEntity.toJson())
          .then((value) {
        if (kDebugMode) {
          print("Notification Added");
        }
      }).catchError((error) {
        if (kDebugMode) {
          print("Failed to add Notification: $error");
        }
      });
      return '200';
    } catch (e) {
      return 'lỗi: $e';
    }
  }

  @override
  Future<List<NotificationEntity>> getAllNotifications(int id) async {
    final db = FirebaseFirestore.instance;
    List<NotificationEntity> notificationList = [];
    await Future.delayed(const Duration(seconds: 2));
    await db
        .collection("Notification")
        .where('idUser', isEqualTo: id).orderBy('createAt',descending: true)
        .get()
        .then(
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
