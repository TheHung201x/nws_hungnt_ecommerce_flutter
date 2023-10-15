import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBarProductDetail extends StatelessWidget {
  const AppBarProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: context.pop,
          child: SvgPicture.asset(
            AppImages.back,
            height: 40,
            width: 40,
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
              color: AppColors.white, shape: BoxShape.circle),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            AppImages.bag,
            height: 40,
            width: 40,
          ),
        )
      ],
    );
  }
}
