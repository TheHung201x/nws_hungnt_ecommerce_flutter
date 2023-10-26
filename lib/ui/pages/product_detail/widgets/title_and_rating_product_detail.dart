import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleAndRatingProductDetail extends StatelessWidget {
  const TitleAndRatingProductDetail({Key? key, required this.productEntity})
      : super(key: key);
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productEntity.title,
            style: AppTextStyle.blackS18Bold,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              productEntity.description,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: AppTextStyle.greyS12,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.icStars,
                height: 12,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '(320 ${S.current.review})',
                style: AppTextStyle.blackS14,
              )
            ],
          ),
        ],
      ),
    );
  }
}
