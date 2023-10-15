import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/enums/max_time_ago.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:ecommerce/ui/pages/notification/notification_cubit.dart';
import 'package:ecommerce/utils/time_ago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationCubit();
      },
      child: const NotificationChildPage(),
    );
  }
}

class NotificationChildPage extends StatefulWidget {
  const NotificationChildPage({Key? key}) : super(key: key);

  @override
  State<NotificationChildPage> createState() => _NotificationChildPageState();
}

class _NotificationChildPageState extends State<NotificationChildPage> {
  late NotificationCubit _notificationCubit;
  List<NotificationEntity> listNotifi = [
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
    NotificationEntity(
        title: 'You have added the item to the cart',
        image:
            'https://i.imgur.com/rUWNzYa.jpeg',
        createAt: DateTime.now().toString()),
  ];

  @override
  void initState() {
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    super.initState();
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.back,
                      height: 40,
                      width: 40,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ]),
                      child: SvgPicture.asset(
                        AppImages.about,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Notification',
                style: AppTextStyle.blackS20W800,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                itemCount: listNotifi.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            imageUrl: listNotifi[index].image,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.network(AppImages.imageDefault),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listNotifi[index].title, style: AppTextStyle.blackS14Opacity,),
                                const SizedBox(height: 5,),
                                Text(getTimeAgo(listNotifi[index].createAt, MaxAgoType.week, true),style: AppTextStyle.greyA,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: AppColors.border,thickness: 1,);
                  },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
