// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get current_language {
    return Intl.message(
      'English',
      name: 'current_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_english {
    return Intl.message(
      'English',
      name: 'language_english',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng việt`
  String get language_vietnamese {
    return Intl.message(
      'Tiếng việt',
      name: 'language_vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `20% Discount \nNew Arrival Product`
  String get onboarding_title_01 {
    return Intl.message(
      '20% Discount \nNew Arrival Product',
      name: 'onboarding_title_01',
      desc: '',
      args: [],
    );
  }

  /// `Take Advantage \nOf The Ofter Shopping`
  String get onboarding_title_02 {
    return Intl.message(
      'Take Advantage \nOf The Ofter Shopping',
      name: 'onboarding_title_02',
      desc: '',
      args: [],
    );
  }

  /// `All Types Offers \nWithin Your Reach`
  String get onboarding_title_03 {
    return Intl.message(
      'All Types Offers \nWithin Your Reach',
      name: 'onboarding_title_03',
      desc: '',
      args: [],
    );
  }

  /// `Publish up your selfies to make yourself \nmore beautiful with this app`
  String get onboarding_sub_title {
    return Intl.message(
      'Publish up your selfies to make yourself \nmore beautiful with this app',
      name: 'onboarding_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get title_login {
    return Intl.message(
      'Welcome!',
      name: 'title_login',
      desc: '',
      args: [],
    );
  }

  /// `please login or sign up to continue our app`
  String get sub_title_login {
    return Intl.message(
      'please login or sign up to continue our app',
      name: 'sub_title_login',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get validate_email_empty {
    return Intl.message(
      'Please enter email',
      name: 'validate_email_empty',
      desc: '',
      args: [],
    );
  }

  /// `Email invalid`
  String get validate_email_invalid {
    return Intl.message(
      'Email invalid',
      name: 'validate_email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter username`
  String get validate_username_empty {
    return Intl.message(
      'Please enter username',
      name: 'validate_username_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get validate_password_empty {
    return Intl.message(
      'Please enter password',
      name: 'validate_password_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password must be longer than or equal to 4 characters`
  String get validate_password_invalid {
    return Intl.message(
      'Password must be longer than or equal to 4 characters',
      name: 'validate_password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Password and Confirm Password don't match`
  String get validate_confirm_password {
    return Intl.message(
      'Password and Confirm Password don\'t match',
      name: 'validate_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Create an new account`
  String get sub_title_sign_up {
    return Intl.message(
      'Create an new account',
      name: 'sub_title_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account you have to agree with our them & condication`
  String get title_checkbox_agree_sign_up {
    return Intl.message(
      'By creating an account you have to agree with our them & condication',
      name: 'title_checkbox_agree_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get login_with_facebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'login_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get login_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get login_with_apple {
    return Intl.message(
      'Continue with Apple',
      name: 'login_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `Successful!`
  String get title_success {
    return Intl.message(
      'Successful!',
      name: 'title_success',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully registered in \nour app and start working in it`
  String get sub_title_success {
    return Intl.message(
      'You have successfully registered in \nour app and start working in it',
      name: 'sub_title_success',
      desc: '',
      args: [],
    );
  }

  /// `Start shopping`
  String get start_shopping {
    return Intl.message(
      'Start shopping',
      name: 'start_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Search Category`
  String get search_categories {
    return Intl.message(
      'Search Category',
      name: 'search_categories',
      desc: '',
      args: [],
    );
  }

  /// `Categories Not Found`
  String get not_found_categories {
    return Intl.message(
      'Categories Not Found',
      name: 'not_found_categories',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `No Categories Yet`
  String get empty_categories {
    return Intl.message(
      'No Categories Yet',
      name: 'empty_categories',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get my_cart {
    return Intl.message(
      'My Cart',
      name: 'my_cart',
      desc: '',
      args: [],
    );
  }

  /// `No products in the cart`
  String get empty_in_cart {
    return Intl.message(
      'No products in the cart',
      name: 'empty_in_cart',
      desc: '',
      args: [],
    );
  }

  /// `total`
  String get total {
    return Intl.message(
      'total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get item {
    return Intl.message(
      'item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Proceed To Checkout`
  String get proceed_to_checkout {
    return Intl.message(
      'Proceed To Checkout',
      name: 'proceed_to_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Notifi`
  String get notifi {
    return Intl.message(
      'Notifi',
      name: 'notifi',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications Yet`
  String get empty_notifications {
    return Intl.message(
      'No Notifications Yet',
      name: 'empty_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get confirm_log_out {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'confirm_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Available in stock`
  String get available_in_stock {
    return Intl.message(
      'Available in stock',
      name: 'available_in_stock',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size_product {
    return Intl.message(
      'Size',
      name: 'size_product',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description_product {
    return Intl.message(
      'Description',
      name: 'description_product',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get total_price_product {
    return Intl.message(
      'Total Price',
      name: 'total_price_product',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get add_to_cart {
    return Intl.message(
      'Add to cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Cannot decrease the quantity anymore`
  String get decrease_error {
    return Intl.message(
      'Cannot decrease the quantity anymore',
      name: 'decrease_error',
      desc: '',
      args: [],
    );
  }

  /// `Login success`
  String get login_success {
    return Intl.message(
      'Login success',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again`
  String get login_error {
    return Intl.message(
      'An error occurred, please try again',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect Email or Password`
  String get login_fail {
    return Intl.message(
      'Incorrect Email or Password',
      name: 'login_fail',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `months`
  String get months {
    return Intl.message(
      'months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get week {
    return Intl.message(
      'week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `weeks`
  String get weeks {
    return Intl.message(
      'weeks',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `just now`
  String get just_now {
    return Intl.message(
      'just now',
      name: 'just_now',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get ago {
    return Intl.message(
      'ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
