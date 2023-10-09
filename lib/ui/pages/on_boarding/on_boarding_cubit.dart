import 'package:ecommerce/database/share_preferences_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState());

  void setFlag () async{
    SharedPreferencesHelper.setOnboard();
  }
}
