import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarCart extends StatelessWidget {
  const AppBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.centerRight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: SvgPicture.asset(
              AppImages.icBag,
            ),
          ),
          BlocBuilder<CartCubit, CartState>(
            buildWhen: (previous, current) {
              return previous.getAllCartStatus != current.getAllCartStatus;
            },
            builder: (context, state) {
              return state.cartList.isNotEmpty
                  ? Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: const BoxDecoration(
                            color: AppColors.black, shape: BoxShape.circle),
                        child: Text(
                          '${state.cartList.length}',
                          style: AppTextStyle.whiteS12,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
