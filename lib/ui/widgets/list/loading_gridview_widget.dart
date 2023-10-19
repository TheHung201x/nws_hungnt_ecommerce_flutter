import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingGridViewWidget extends StatelessWidget {
  const LoadingGridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        childAspectRatio: 3 / 3.3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return const ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: AppShimmer(),
        );
      },
    );
  }
}
