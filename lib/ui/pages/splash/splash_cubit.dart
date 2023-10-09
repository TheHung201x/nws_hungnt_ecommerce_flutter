import 'package:dio/dio.dart';
import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/database/share_preferences_helper.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/ui/pages/splash/splash_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepo;
  // final AppCubit appCubit;

  SplashCubit({
    required this.navigator,
    required this.authRepo,
    // required this.appCubit,
  }) : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await authRepo.getToken();
    if (token == null) {
      if (await SharedPreferencesHelper.isOnboardCompleted()) {
        navigator.openSignInPage();
      } else {
        navigator.openOnboardingPage();
      }
    } else {
      try {
        //Profile
        // await appCubit.getProfile();
      } catch (error, s) {
       debugPrint('error $error - $s');
        //Check 401
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            //Todo
            // authService.signOut();
            checkLogin();
            return;
          }
        }
        navigator.showSimpleDialog(
          message: "An error happened. Please check your connection!",
          textConfirm: "Retry",
          onConfirm: () {
            checkLogin();
          },
        );
        return;
      }
      navigator.openMainPage();
    }
  }

}
