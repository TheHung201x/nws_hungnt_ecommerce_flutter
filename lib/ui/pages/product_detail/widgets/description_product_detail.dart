import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

class DescriptionProductDetail extends StatelessWidget {
  final ProductEntity productEntity;

  const DescriptionProductDetail({Key? key, required this.productEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.blackS18Bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            productEntity.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.greyA12,
          ),
        ),
      ],
    );
  }
}
