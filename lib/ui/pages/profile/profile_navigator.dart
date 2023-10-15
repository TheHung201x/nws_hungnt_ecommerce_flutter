import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ProfileNavigator extends AppNavigator {
  ProfileNavigator({required BuildContext context}) : super(context: context);

  void openLoginPage() {
    Future.delayed(const Duration(seconds: 2),(){
      GoRouter.of(context).pushReplacementNamed(AppRouter.auth);
    });
  }
}
