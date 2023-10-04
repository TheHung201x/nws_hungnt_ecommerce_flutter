import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState());

  void setFlag (int flag) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('flag', flag);
  }
}
