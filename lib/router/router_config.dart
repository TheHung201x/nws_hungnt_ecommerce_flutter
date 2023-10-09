import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/ui/pages/auth/auth_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:ecommerce/ui/pages/home/home_page.dart';
import 'package:ecommerce/ui/pages/main/main_page.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_page.dart';
import 'package:ecommerce/ui/pages/product_list/product_list_page.dart';
import 'package:ecommerce/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  ///main page
  static const String splash = "/";
  static const String onBoarding = 'onBoarding';
  static const String auth = "auth";
  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String main = "main";
  static const String home = "home";
  static const String productList = "productList";

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(path: splash, builder: (context, state) => const SplashPage()),
    GoRoute(
      name: main,
      path: "/$main",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      name: auth,
      path: "/$auth",
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      name: signIn,
      path: "/$signIn",
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      name: signUp,
      path: "/$signUp",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: home,
      path: "/$home",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: productList,
      path: "/$productList",
      builder: (context, state) => ProductListPage(
        categoryEntity: state.extra as CategoryEntity,
      ),
    ),
    GoRoute(
      name: onBoarding,
      path: "/$onBoarding",
      builder: (context, state) => const OnBoardingPage(),
    ),
  ];
}
