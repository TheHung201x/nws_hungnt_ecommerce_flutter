import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/enums/max_time_ago.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:ecommerce/utils/time_ago.dart';
import 'package:flutter/material.dart';

class ItemNotification extends StatelessWidget {
  final NotificationEntity notificationEntity;

  const ItemNotification({Key? key, required this.notificationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              height: 60,
              width: 60,
              imageUrl: notificationEntity.image,
              placeholder: (context, url) => const AppShimmer(),
              errorWidget: (context, url, error) =>
                  Image.network(AppImages.imageDefaultNetwork),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationEntity.title,
                    style: AppTextStyle.blackS14Opacity,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    getTimeAgo(
                        notificationEntity.createAt, MaxAgoType.week, true),
                    style: AppTextStyle.greyA,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
