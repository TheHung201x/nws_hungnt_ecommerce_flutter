import 'package:flutter/material.dart';

class AppConfigs {
  AppConfigs._();
  static const String appName = "Ecommerce";
  static String get baseUrl => "https://api.escuelajs.co/api/v1";

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'vi';
  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);
}
