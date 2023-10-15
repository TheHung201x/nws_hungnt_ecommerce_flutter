import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/widget/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.authScreen,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    AppButton(
                      title: 'Login',
                      onPressed: () => context.push('/signIn'),
                      backgroundColor: AppColors.white,
                      textStyle: AppTextStyle.blackS16Bold,
                      cornerRadius: 50,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppButton(
                      title: 'Sign Up',
                      onPressed: () => context.push('/signUp'),
                      backgroundColor: AppColors.transparent,
                      textStyle: AppTextStyle.whiteS16Bold,
                      cornerRadius: 50,
                      borderWidth: 1,
                      borderColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
