import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required BuildContext context}) : super(context: context);

  void openHomePage() {
    Future.delayed(const Duration(seconds: 3),(){
      GoRouter.of(context).goNamed(AppRouter.home);
    });
  }
}
