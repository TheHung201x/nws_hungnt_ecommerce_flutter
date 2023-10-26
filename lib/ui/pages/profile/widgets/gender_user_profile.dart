import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:flutter/material.dart';

class GenderUserProfile extends StatelessWidget {
  const GenderUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.current.gender,
          style: AppTextStyle.greyABold,
        ),
        const Spacer(),
        SizedBox(
          width: 220,
          child: Row(
            children: [
              _male(),
              _female(),
            ],
          ),
        )
      ],
    );
  }

  Widget _male() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 40,
      width: 80,
      decoration: BoxDecoration(
          color: AppColors.black, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 14,
            height: 14,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: AppColors.white,
              ),
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
          Text(
            S.current.male,
            style: AppTextStyle.whiteS12Bold,
          )
        ],
      ),
    );
  }

  Widget _female() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        border: Border.all(color: AppColors.greyD),
      ),
      height: 40,
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: AppColors.greyD,
              ),
            ),
          ),
          Text(
            S.current.female,
            style: AppTextStyle.greyA12Blod,
          )
        ],
      ),
    );
  }
}
