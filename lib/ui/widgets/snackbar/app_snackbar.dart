import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String title) {
  final snackBar = SnackBar(
    backgroundColor: AppColors.backgroundDark,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    behavior: SnackBarBehavior.floating,
    content: Text(
      title,
      style: AppTextStyle.whiteS14,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
