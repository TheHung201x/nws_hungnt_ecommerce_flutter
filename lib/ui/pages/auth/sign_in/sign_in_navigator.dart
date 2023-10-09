import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required BuildContext context}) : super(context: context);

  void openMainPage() {
    GoRouter.of(context).pushNamed(AppRouter.main);
  }
}
