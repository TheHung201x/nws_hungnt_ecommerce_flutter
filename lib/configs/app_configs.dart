import 'package:flutter/material.dart';

class AppConfigs {
  AppConfigs._();
  static const String appName = "Ecommerce";
  static String get baseUrl => "https://api.escuelajs.co/api/v1";

  ///Local
  static const appLocal = 'en_US';
  static const appLanguage = 'en';
  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);
}
