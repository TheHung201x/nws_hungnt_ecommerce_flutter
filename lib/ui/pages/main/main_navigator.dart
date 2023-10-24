import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigator extends AppNavigator {
  MainNavigator({required BuildContext context}) : super(context: context);

  void changePage(int index) {
    switch (index) {
      case 0:
        context.go('/${AppRouter.home}');
        break;
      case 1:
        context.go('/${AppRouter.cart}');
        break;
      case 2:
        context.go('/${AppRouter.notifi}');
        break;
      case 3:
        context.go('/${AppRouter.profile}');
        break;
      default:
        throw Exception();
    }
  }
}
