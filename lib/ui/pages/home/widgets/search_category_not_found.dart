import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

class SearchCategoryNotFound extends StatelessWidget {
  const SearchCategoryNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.searchNotFound,
          height: 80,
          width: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Category Not Found...', style: AppTextStyle.blackS16),
      ],
    );
  }
}
