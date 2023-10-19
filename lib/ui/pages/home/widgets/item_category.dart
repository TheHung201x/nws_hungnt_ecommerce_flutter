import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/category/category_entity.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final CategoryEntity categoryEntity;

  const ItemCategory(
      {Key? key, required this.categoryEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height,
            imageUrl:
            categoryEntity.image,
            placeholder: (context, url) =>
                const AppShimmer(),
            errorWidget: (context, url, error) =>
                Image.network(AppImages.imageDefault),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryEntity.name ?? '',
                  style: AppTextStyle.blackS20W800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${categoryEntity.totalProduct} Product',
                  style: AppTextStyle.blackS18W500,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
