import 'package:ecommerce/ui/pages/auth/auth_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_page.dart';
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
  static const String main = "main";
  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String auth = "auth";
  static const String onBoarding = 'onBoarding';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(path: splash, builder: (context, state) => const SplashPage()),
    // GoRoute(
    //   name: main,
    //   path: "/$main",
    //   builder: (context, state) => const MainPage(),
    // ),
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
    // GoRoute(
    //   name: notificationDetail,
    //   path: "/notificationDetail",
    //   builder: (context, state) => NotificationDetailPage(
    //     arguments: NotificationDetailArguments(
    //       //Todo
    //         notification: NotificationEntity()),
    //   ),
    // ),
    GoRoute(
      name: onBoarding,
      path: "/$onBoarding",
      builder: (context, state) => const OnBoardingPage(),
    ),
  ];
}