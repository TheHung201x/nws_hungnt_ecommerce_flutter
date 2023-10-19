import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class ErrorLoadWidget extends StatelessWidget {
  final VoidCallback onPress;
  const ErrorLoadWidget({Key? key, required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.oops,
          height: 200,
          width: 200,
        ),
        Text('Something went wrong...',
            style: AppTextStyle.blackS16W600),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AppButton(
            title: 'Try again',
            cornerRadius: 30,
            backgroundColor: AppColors.black,
            onPressed: onPress,
          ),
        )
      ],
    );
  }
}
