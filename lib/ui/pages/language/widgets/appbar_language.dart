import 'package:ecommerce/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBarLanguage extends StatelessWidget {
  const AppBarLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40),
      child: GestureDetector(
        onTap: context.pop,
        child: SvgPicture.asset(
          AppImages.icBack,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
