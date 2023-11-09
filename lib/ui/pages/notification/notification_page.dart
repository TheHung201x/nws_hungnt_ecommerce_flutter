import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/notification/notification_cubit.dart';
import 'package:ecommerce/ui/pages/notification/widgets/appbar_notitfication.dart';
import 'package:ecommerce/ui/pages/notification/widgets/item_notification.dart';
import 'package:ecommerce/ui/pages/notification/widgets/title_notification.dart';
import 'package:ecommerce/ui/widgets/list/empty_list_widget.dart';
import 'package:ecommerce/ui/widgets/list/loading_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NotificationChildPage();
  }
}

class NotificationChildPage extends StatefulWidget {
  const NotificationChildPage({Key? key}) : super(key: key);

  @override
  State<NotificationChildPage> createState() => _NotificationChildPageState();
}

class _NotificationChildPageState extends State<NotificationChildPage> {
  late NotificationCubit _notificationCubit;
  late UserRepository userRepository;
  late UserEntity userEntity;

  @override
  void initState() {
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
    userEntity = UserEntity();
    getUser();
    super.initState();
  }

  void getUser() async {
    userEntity = await userRepository.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarNotification(),
              const TitleNotification(),
              _showListNotification(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showListNotification() {
    return Expanded(
      child: BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (previous, current) {
          return previous.getAllNotificationsStatus !=
              current.getAllNotificationsStatus;
        },
        builder: (context, state) {
          if (state.getAllNotificationsStatus == LoadStatus.success) {
            final listNotification = state.notificationList;
            return listNotification.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      _notificationCubit.getAllNotifications();
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: listNotification.length,
                      itemBuilder: (context, index) {
                        return ItemNotification(
                          notificationEntity: listNotification[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: AppColors.border,
                          thickness: 1,
                        );
                      },
                    ),
                  )
                : _emptyListNotifications();
          } else {
            return const LoadingListWidget();
          }
        },
      ),
    );
  }

  Widget _emptyListNotifications() {
    return EmptyListWidget(
      text: S.current.empty_notifications,
      linkImage: AppImages.emptyNotification,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        _notificationCubit.getAllNotifications();
      },
    );
  }
}
