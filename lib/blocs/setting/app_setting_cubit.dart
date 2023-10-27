import 'package:ecommerce/configs/app_configs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> with HydratedMixin{
  AppSettingCubit() : super(const AppSettingState());

  void resetSetting() {
    emit(const AppSettingState());
  }

  void changeLocal({required Locale locale}) {
    emit(state.copyWith(locale: locale));
  }

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState(locale: json['local'] is String
        ? Locale.fromSubtags(languageCode: json['local'])
        : AppConfigs.defaultLocal,);
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return {
      'local': state.locale.languageCode,
    };
  }

}
