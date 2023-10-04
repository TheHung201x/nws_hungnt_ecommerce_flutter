import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void nextScreen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('flag') != 1) {
      Future.delayed(
        const Duration(seconds: 3),
            () => context.go('/onBoarding'),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
            () => context.go('/auth'),
      );
    }
  }
}
