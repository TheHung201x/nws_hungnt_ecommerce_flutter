import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_cubit.dart';
import 'package:ecommerce/ui/pages/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit(),
          ),
          BlocProvider(
            create: (context) => OnBoardingCubit(),
          ),
          BlocProvider(create: (context) {
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            return SignInCubit(authRepository: authRepo);
          }),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
