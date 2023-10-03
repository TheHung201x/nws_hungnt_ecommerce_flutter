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
  static const String notificationList = "notificationList";
  static const String notificationDetail = "notificationDetail";
  static const String onboarding = 'onboarding';
  static const String movieDetail = 'movieDetail';
  static const String photoView = 'photoView';
  static const String profile = 'profile';
  static const String setting = 'setting';
  static const String updateProfile = 'updateProfile';
  static const String updateAvatar = 'updateAvatar';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(path: splash, builder: (context, state) => const SplashPage()),
    // GoRoute(
    //   name: main,
    //   path: "/$main",
    //   builder: (context, state) => const MainPage(),
    // ),
    // GoRoute(
    //   name: signIn,
    //   path: "/$signIn",
    //   builder: (context, state) => const SignInPage(),
    // ),
    // GoRoute(
    //   name: notificationList,
    //   path: "/$notificationList",
    //   builder: (context, state) => const NotificationListPage(),
    // ),
    // GoRoute(
    //   name: notificationDetail,
    //   path: "/notificationDetail",
    //   builder: (context, state) => NotificationDetailPage(
    //     arguments: NotificationDetailArguments(
    //       //Todo
    //         notification: NotificationEntity()),
    //   ),
    // ),
    // GoRoute(
    //   name: onboarding,
    //   path: "/$onboarding",
    //   builder: (context, state) => const OnboardingPage(),
    // ),
    // GoRoute(
    //   name: movieDetail,
    //   path: "/$movieDetail/:id",
    //   builder: (context, state) => MovieDetailPage(
    //     arguments: MovieDetailArguments(
    //         id: int.tryParse(state.pathParameters["id"] ?? '') ?? 0),
    //   ),
    // ),
    // GoRoute(
    //   name: photoView,
    //   path: "/$photoView",
    //   builder: (context, state) => PhotoViewPage(
    //     arguments: PhotoViewArguments(images: state.extra as List<String>),
    //   ),
    // ),
    // GoRoute(
    //   name: setting,
    //   path: "/$setting",
    //   builder: (context, state) => const SettingPage(),
    // ),
    // GoRoute(
    //   name: updateProfile,
    //   path: "/$updateProfile",
    //   builder: (context, state) => const UpdateProfilePage(),
    // ),
    // GoRoute(
    //   name: updateAvatar,
    //   path: "/$updateAvatar",
    //   builder: (context, state) => const UpdateAvatarPage(),
    // ),
    // GoRoute(
    //   name: profile,
    //   path: "/$profile",
    //   builder: (context, state) => const ProfilePage(),
    // ),
  ];
}