import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleAndRatingProductDetail extends StatelessWidget {
  const TitleAndRatingProductDetail({Key? key, required this.productEntity})
      : super(key: key);
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productEntity.title,
          style: AppTextStyle.blackS20W800,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            productEntity.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.greyS16,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              AppImages.stars,
              height: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('(320 Review)')
          ],
        ),
      ],
    );
  }
}
