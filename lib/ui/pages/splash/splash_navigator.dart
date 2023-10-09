import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required BuildContext context}) : super(context: context);

  void openSignInPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.signIn);
  }

  void openMainPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.main);
  }

  void openOnboardingPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.onBoarding);
  }
}
