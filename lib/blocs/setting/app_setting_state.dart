part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Locale locale;

  const AppSettingState({
    this.locale = AppConfigs.defaultLocal,
  });

  @override
  List<Object?> get props => [locale];

  AppSettingState copyWith({
    Locale? locale,
  }) {
    return AppSettingState(locale: locale ?? this.locale);
  }
}
