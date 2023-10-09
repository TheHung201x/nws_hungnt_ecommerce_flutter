import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/router/router_config.dart';
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
      ],
      child: BlocProvider<AppCubit>(
        create: (context) {
          final userRepository = RepositoryProvider.of<UserRepository>(context);
          final authRepository = RepositoryProvider.of<AuthRepository>(context);
          return AppCubit(
            userRepository: userRepository,
            authRepository: authRepository,
          );
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
