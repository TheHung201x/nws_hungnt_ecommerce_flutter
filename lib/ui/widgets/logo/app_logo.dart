import 'package:ecommerce/common/app_images.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, required this.showingKeyboard}) : super(key: key);
  final bool showingKeyboard;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
        height: showingKeyboard ? 0 : 100,
        margin: const EdgeInsets.symmetric(vertical: 40),
      child: Image.asset(AppImages.logoFashion),
    );
  }
}
