import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/models/entities/product_entity.dart';
import 'package:ecommerce/ui/pages/auth/auth_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_success_page.dart';
import 'package:ecommerce/ui/pages/cart/cart_page.dart';
import 'package:ecommerce/ui/pages/home/home_page.dart';
import 'package:ecommerce/ui/pages/main/main_page.dart';
import 'package:ecommerce/ui/pages/notification/notification_page.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_page.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_page.dart';
import 'package:ecommerce/ui/pages/product_list/product_list_page.dart';
import 'package:ecommerce/ui/pages/profile/profile_page.dart';
import 'package:ecommerce/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final rootNavigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: rootNavigationKey,
    routes: _routes,
  );

  ///main page
  static const String splash = "/";
  static const String onBoarding = 'onBoarding';
  static const String auth = "auth";
  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String signUpSuccess = "signUpSuccess";

  // static const String main = "main";
  static const String home = "home";
  static const String productList = "productList";
  static const String productDetail = "productDetail";
  static const String cart = "cart";
  static const String notifi = "notifi";
  static const String profile = "profile";

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(path: splash, builder: (context, state) => const SplashPage()),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: MainPage(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          name: home,
          path: '/$home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: productList,
          path: '/$productList',
          builder: (context, state) => ProductListPage(
            categoryEntity: state.extra as CategoryEntity,
          ),
        ),
        GoRoute(
          name: cart,
          path: "/$cart",
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          name: notifi,
          path: "/$notifi",
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          name: profile,
          path: "/$profile",
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: productDetail,
      path: '/$productDetail',
      builder: (context, state) => ProductDetailPage(
        productEntity: state.extra as ProductEntity,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: auth,
      path: "/$auth",
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: signIn,
      path: "/$signIn",
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: signUp,
      path: "/$signUp",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: signUpSuccess,
      path: "/$signUpSuccess",
      builder: (context, state) => const SignUpSuccessPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: onBoarding,
      path: "/$onBoarding",
      builder: (context, state) => const OnBoardingPage(),
    ),
  ];
}
