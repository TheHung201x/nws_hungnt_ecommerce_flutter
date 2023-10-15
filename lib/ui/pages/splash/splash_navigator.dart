import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required BuildContext context}) : super(context: context);

  void openAuthPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.auth);
  }

  void openHomePage() {
    context.goNamed(AppRouter.home);
  }

  void openOnboardingPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.onBoarding);
  }
}
