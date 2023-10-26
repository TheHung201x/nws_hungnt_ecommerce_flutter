import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:flutter/material.dart';

class TitleCart extends StatelessWidget {
  const TitleCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.current.my_cart,
      style: AppTextStyle.blackS20W800,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
