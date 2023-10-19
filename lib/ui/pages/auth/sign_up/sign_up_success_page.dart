import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:ecommerce/ui/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignUpSuccessChildPage();
  }
}

class SignUpSuccessChildPage extends StatefulWidget {
  const SignUpSuccessChildPage({Key? key}) : super(key: key);

  @override
  State<SignUpSuccessChildPage> createState() => _SignUpSuccessChildPageState();
}

class _SignUpSuccessChildPageState extends State<SignUpSuccessChildPage> {
  late SignUpNavigator signUpNavigator;

  @override
  void initState() {
    signUpNavigator = SignUpNavigator(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.success,
              height: 50,
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 200),
              child: ListTile(
                  title: Text(
                    'Successful!',
                    style: AppTextStyle.blackS24Bold,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'You have successfully registered in \nour app and start working in it',
                    style: AppTextStyle.greyS14,
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: EdgeInsets.zero),
            ),
            AppButton(
              title: 'Start shopping',
              cornerRadius: 30,
              backgroundColor: AppColors.black,
              onPressed: () => signUpNavigator.openHomePage(),
              textStyle: AppTextStyle.whiteS16Bold,
            )
          ],
        ),
      ),
    );
  }
}
