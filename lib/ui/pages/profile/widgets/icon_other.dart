import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class IconOtherInProfile extends StatelessWidget {
  const IconOtherInProfile({
    Key? key,
    required this.linkImg,
    required this.title,
    required this.isSwitch,
    required this.isText,
  }) : super(key: key);
  final String linkImg;
  final String title;
  final bool isSwitch;
  final bool hasSwitch = true;
  final bool isText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 14),
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundTabBar,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SvgPicture.asset(
                  linkImg,
                ),
              ),
              Text(title, style: AppTextStyle.blackS14Bold),
            ],
          ),
          !isSwitch
              ? Row(
                  children: [
                    isText
                        ? GestureDetector(
                            onTap: () => context.pushNamed(AppRouter.language),
                            child: Text(
                              S.current.current_language,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                )
              : Row(
                  children: [
                    isText ? Text(S.current.off) : const SizedBox.shrink(),
                    const SizedBox(
                      width: 4,
                    ),
                    CupertinoSwitch(
                      value: hasSwitch,
                      activeColor: AppColors.black,
                      onChanged: (bool value) {
                        // hasSwitch = !hasSwitch;
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
