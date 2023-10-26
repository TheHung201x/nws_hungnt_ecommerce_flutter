import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:flutter/material.dart';

class ItemOnboarding extends StatelessWidget {
  final String pathImage;
  final String title;

  const ItemOnboarding({Key? key, required this.pathImage, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            transform: Matrix4.skewY(-0.07),
            height: MediaQuery.of(context).size.height / 2 + 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  pathImage,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: AppTextStyle.blackS24Bold,
            ),
          ),
          subtitle: Text(
            S.current.onboarding_sub_title,
            style: AppTextStyle.grey,
          ),
        )
      ],
    );
  }
}
