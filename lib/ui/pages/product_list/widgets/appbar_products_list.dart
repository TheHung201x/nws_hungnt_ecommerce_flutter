import 'package:ecommerce/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppbarProductsList extends StatelessWidget {
  const AppbarProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: SvgPicture.asset(
              AppImages.icBack,
              height: 40,
              width: 40,
            ),
          ),
          SvgPicture.asset(
              AppImages.icSearch,
              height: 20,
              width: 20,
            ),
        ],
      ),
    );
  }
}
