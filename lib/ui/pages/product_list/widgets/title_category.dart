import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

class TitleCategory extends StatelessWidget {
  final String nameCategory;

  const TitleCategory({Key? key, required this.nameCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        nameCategory,
        style: AppTextStyle.blackS20W800,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
