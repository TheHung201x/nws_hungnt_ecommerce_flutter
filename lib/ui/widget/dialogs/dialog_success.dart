import 'package:lottie/lottie.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

showDialogSuccess({BuildContext? context, String? content, bool? close}) {
  showDialog(
    context: context!,
    barrierDismissible: close ?? true,
    builder: (context) => Center(
      heightFactor: double.minPositive,
      widthFactor: double.minPositive,
      child: Container(
        height: 120,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.5),
        ),
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/animation/success.json',
                height: 50, width: 50),
            const SizedBox(
              height: 10,
            ),
            Text(
              content!,
              style: AppTextStyle.whiteS14,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  );
}
