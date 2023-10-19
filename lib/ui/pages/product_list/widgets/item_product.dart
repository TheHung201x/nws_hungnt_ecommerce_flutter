import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:ecommerce/utils/app_int_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemProduct extends StatelessWidget {
  final ProductEntity productEntity;

  const ItemProduct({Key? key, required this.productEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: productEntity.images[0],
                  placeholder: (context, url) => const AppShimmer(),
                  errorWidget: (context, url, error) =>
                      Image.network(AppImages.imageDefault),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: SvgPicture.asset(
                    AppImages.icFavouriteBlack,
                    width: 26,
                    height: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          productEntity.title,
          style: AppTextStyle.blackS18Bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            productEntity.description,
            style: AppTextStyle.greyS12W800,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '\$${productEntity.price.formatPrice}',
          style: AppTextStyle.blackS18Bold,
        ),
      ],
    );
  }
}
