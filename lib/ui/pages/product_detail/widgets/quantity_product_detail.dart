import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityProductDetail extends StatefulWidget {
  final ProductEntity productEntity;

  const QuantityProductDetail({Key? key, required this.productEntity})
      : super(key: key);

  @override
  State<QuantityProductDetail> createState() => _QuantityProductDetailState();
}

class _QuantityProductDetailState extends State<QuantityProductDetail> {
  late ProductDetailCubit _productDetailCubit;

  @override
  void initState() {
    _productDetailCubit = BlocProvider.of<ProductDetailCubit>(context);
    _productDetailCubit.getQuantityAndTotalPrice(widget.productEntity.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: const BoxDecoration(
                color: AppColors.backgroundTabBar,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => _productDetailCubit.decrement(),
                      child: const Icon(Icons.remove)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${state.quantity}',
                      style: AppTextStyle.blackS15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _productDetailCubit.increment(),
                    child: const Icon(
                      Icons.add_sharp,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Available in stock',
              style: AppTextStyle.blackS12W800,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      },
    );
  }
}
