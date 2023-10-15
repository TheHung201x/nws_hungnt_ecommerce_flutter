import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  ///Black
  static const black = TextStyle(color: Colors.black, fontFamily: 'Poppins');

  //s12
  static final blackS12 = black.copyWith(fontSize: 12);
  static final blackS12W800 = blackS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final blackS14 = black.copyWith(fontSize: 14);
  static final blackS14Opacity = black.copyWith(fontSize: 14,color: Colors.black.withOpacity(0.9));
  static final blackS14Bold = blackS14.copyWith(fontWeight: FontWeight.bold);
  static final blackS14W800 = blackS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final blackS16 = black.copyWith(fontSize: 16);
  static final blackS16Bold = blackS16.copyWith(fontWeight: FontWeight.bold);
  static final blackS16W600 = blackS16.copyWith(fontWeight: FontWeight.w600);
  static final blackS16W800 = blackS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final blackS18 = black.copyWith(fontSize: 18);
  static final blackS18Bold = blackS18.copyWith(fontWeight: FontWeight.w700);
  static final blackS18W500 = blackS18.copyWith(fontWeight: FontWeight.w500);
  static final blackS20W800 =
      blackS18.copyWith(fontWeight: FontWeight.w800, fontSize: 20);

  //s30
  static final blackS24 = black.copyWith(fontSize: 24);
  static final blackS24Bold = blackS24.copyWith(fontWeight: FontWeight.bold);

  ///White
  static const white = TextStyle(color: Colors.white, fontFamily: 'Poppins');

  //s12
  static final whiteS12 = white.copyWith(fontSize: 12);
  static final whiteS12Bold = whiteS12.copyWith(fontWeight: FontWeight.bold);
  static final whiteS12W800 = whiteS12.copyWith(fontWeight: FontWeight.w800);

  // //s14
  // static final whiteS14 = white.copyWith(
  //   fontSize: 14,
  //   decoration: TextDecoration.none,
  // );
  // static final whiteS14Bold = whiteS14.copyWith(fontWeight: FontWeight.bold);
  // static final whiteS14W800 = whiteS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final whiteS16 = white.copyWith(fontSize: 16);
  static final whiteS16Bold = whiteS16.copyWith(fontWeight: FontWeight.bold);
  static final whiteS16W800 = whiteS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final whiteS18 = white.copyWith(fontSize: 18);
  static final whiteS18Bold = whiteS18.copyWith(fontWeight: FontWeight.bold);
  static final whiteS18W800 = whiteS18.copyWith(fontWeight: FontWeight.w800);

  ///Gray
  static const grey = TextStyle(color: Colors.grey, fontFamily: 'Poppins');
  static const greyA =
      TextStyle(color: Color(0xFFAAAAAA), fontFamily: 'Poppins');
  static final greyA12 = greyA.copyWith(fontSize: 12);
  static final greyA14 = greyA.copyWith(fontSize: 14);
  static final greyA16 = greyA.copyWith(fontSize: 16);
  static final greyABold = greyA.copyWith(fontWeight: FontWeight.bold);

  //s12
  static final greyS12 = grey.copyWith(fontSize: 12);
  static final greySA12 = greyA.copyWith(fontSize: 12);
  static final greyS12Bold = greyS12.copyWith(fontWeight: FontWeight.bold);
  static final greyS12W800 = greyS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final greyS14 = grey.copyWith(fontSize: 14);
  static final greyS14Bold = greyS14.copyWith(fontWeight: FontWeight.bold);
  static final greyS14W800 = greyS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final greyS16 = grey.copyWith(fontSize: 16);
  static final greyS16Bold = greyS16.copyWith(fontWeight: FontWeight.bold);
  static final greyS16W800 = greyS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final greyS18 = grey.copyWith(fontSize: 18);
  static final greyS18Bold = greyS18.copyWith(fontWeight: FontWeight.bold);
  static final greyS18W800 = greyS18.copyWith(fontWeight: FontWeight.w800);
}
