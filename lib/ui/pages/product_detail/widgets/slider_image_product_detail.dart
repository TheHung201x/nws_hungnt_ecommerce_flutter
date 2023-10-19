import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/app_bar_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/dot_indicator_image_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/images_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderImageProductDetail extends StatelessWidget {
  const SliderImageProductDetail(
      {Key? key, required this.pageController, required this.productEntity})
      : super(key: key);
  final PageController pageController;
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2 + 100,
      child: Stack(
        children: [
          ImageProductDetail(
              productEntity: productEntity, controller: pageController),
          const Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: AppBarProductDetail(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: SvgPicture.asset(
              AppImages.icFavouriteWhite,
              height: 30,
              width: 30,
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: DotIndicatorProductDetail(
                productEntity: productEntity,
                controller: pageController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
