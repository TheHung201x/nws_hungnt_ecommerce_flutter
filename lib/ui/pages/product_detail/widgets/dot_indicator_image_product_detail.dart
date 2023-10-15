import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotIndicatorProductDetail extends StatelessWidget {
  const DotIndicatorProductDetail(
      {Key? key, required this.productEntity, required this.controller})
      : super(key: key);
  final ProductEntity productEntity;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      axisDirection: Axis.horizontal,
      count: productEntity.images.length,
      controller: controller,
      effect: ScaleEffect(
          activeDotColor: AppColors.white.withOpacity(0.5),
          dotColor: AppColors.white,
          dotHeight: 8,
          dotWidth: 8,
          spacing: 16,
          scale: 2,
          activeStrokeWidth: 2,
          activePaintStyle: PaintingStyle.stroke),
    );
  }
}
