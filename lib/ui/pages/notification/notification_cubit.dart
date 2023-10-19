import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationCubit({required this.notificationRepository})
      : super(const NotificationState());

  Future<void> addNewNotification(NotificationEntity notificationEntity) async {
    emit(
      state.copyWith(addNewNotificationStatus: LoadStatus.loading),
    );
    try {
      await notificationRepository.addToNotification(
          notificationEntity: notificationEntity);
      emit(
        state.copyWith(addNewNotificationStatus: LoadStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(addNewNotificationStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> getAllNotifications(int id) async {
    emit(state.copyWith(getAllNotificationsStatus: LoadStatus.loading));
    try {
      final notificationList =
          await notificationRepository.getAllNotifications(id);
      emit(
        state.copyWith(
          getAllNotificationsStatus: LoadStatus.success,
          notificationList: notificationList,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
            getAllNotificationsStatus: LoadStatus.failure,
            notificationList: []),
      );
    }
  }
}
