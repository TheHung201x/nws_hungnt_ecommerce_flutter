import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBarNotification extends StatelessWidget {
  const AppBarNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.goNamed(AppRouter.home),
            child: SvgPicture.asset(
              AppImages.icBack,
              height: 40,
              width: 40,
            ),
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
              AppImages.icMore,
            ),
          ),
        ],
      ),
    );
  }
}
