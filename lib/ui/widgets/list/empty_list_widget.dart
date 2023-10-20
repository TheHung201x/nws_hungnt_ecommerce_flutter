import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final String linkImage;
  final RefreshCallback? onRefresh;

  const EmptyListWidget({
    Key? key,
    this.text = 'No data',
    this.linkImage = AppImages.imageDefault,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? _onRefreshData,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.asset(
                linkImage,
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10,),
              Text(
                text,
                style: AppTextStyle.greyS18W800,
              ),
            ],
          );
        },
        itemCount: 1,
      ),
    );
  }

  Future<void> _onRefreshData() async {}
}
