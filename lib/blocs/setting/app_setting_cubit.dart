import 'package:ecommerce/configs/app_configs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  void resetSetting() {
    emit(const AppSettingState());
  }

  void changeLocal({required Locale locale}) {
    emit(state.copyWith(locale: locale));
  }

}
