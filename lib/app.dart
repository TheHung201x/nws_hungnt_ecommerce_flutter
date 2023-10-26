import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/blocs/setting/app_setting_cubit.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:ecommerce/repositories/notification_repository.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:ecommerce/ui/pages/home/home_cubit.dart';
import 'package:ecommerce/ui/pages/notification/notification_cubit.dart';
import 'package:ecommerce/ui/pages/profile/profile_cubit.dart';
import 'package:ecommerce/ui/pages/profile/profile_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) {
            return CategoryRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) {
            return ProductRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<UserRepository>(
          create: (context) {
            return UserRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<CartRepository>(
          create: (context) {
            return CartRepositoryImpl();
          },
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) {
            return NotificationRepositoryImpl();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) {
              return AppCubit(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              );
            },
          ),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
          BlocProvider(
            create: (context) {
              final categoryRepo =
                  RepositoryProvider.of<CategoryRepository>(context);
              return HomeCubit(categoryRepository: categoryRepo)
                ..getAllCategories();
            },
          ),
          BlocProvider(
            create: (context) {
              return CartCubit(
                cartRepository: RepositoryProvider.of<CartRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
                appNavigator: AppNavigator(context: context),
              )..getAllCart();
            },
          ),
          BlocProvider(
            create: (context) {
              return NotificationCubit(
                notificationRepository:
                    RepositoryProvider.of<NotificationRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
              )..getAllNotifications();
            },
          ),
          BlocProvider(
            create: (context) {
              return ProfileCubit(
                appCubit: RepositoryProvider.of<AppCubit>(context),
              )..getUser();
            },
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (previous, current) {
            return previous.locale != current.locale;
          },
          builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate,
              ],
              locale: state.locale,
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
