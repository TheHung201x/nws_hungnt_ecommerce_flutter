import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required BuildContext context}) : super(context: context);

  void openSignUpSuccess() {
    Future.delayed(const Duration(seconds: 3),(){
      GoRouter.of(context).pushNamed(AppRouter.signUpSuccess);
    });
  }

  void openHomePage() {
    Future.delayed(const Duration(seconds: 3),(){
      GoRouter.of(context).goNamed(AppRouter.home);
    });
  }
}