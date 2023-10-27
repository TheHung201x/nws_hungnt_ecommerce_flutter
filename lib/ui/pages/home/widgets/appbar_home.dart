import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  late AppNavigator appNavigator;

  @override
  void initState() {
    appNavigator = AppNavigator(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40),
      child: GestureDetector(
        onTap: () {
          appNavigator.showSimpleDialog(
            title: S.current.title_confirm_exit,
            message: S.current.messenge_confirm_exit,
            onConfirm: () => SystemNavigator.pop(),
          );
        },
        child: SvgPicture.asset(
          AppImages.icBack,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
