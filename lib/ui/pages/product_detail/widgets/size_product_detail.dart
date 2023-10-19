import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeProductDetail extends StatefulWidget {
  final ProductEntity productEntity;

  const SizeProductDetail({Key? key, required this.productEntity})
      : super(key: key);

  @override
  State<SizeProductDetail> createState() => _SizeProductDetailState();
}

class _SizeProductDetailState extends State<SizeProductDetail> {
  late List<String> listSize;
  late ProductDetailCubit _productDetailCubit;

  @override
  void initState() {
    listSize = ['S', 'M', 'L', 'XL', 'XXL'];
    _productDetailCubit = BlocProvider.of<ProductDetailCubit>(context);
    _productDetailCubit.getQuantityAndTotalPrice(widget.productEntity.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: AppTextStyle.blackS18Bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.5,
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listSize.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _productDetailCubit.chooseSizeProduct(listSize[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: state.size == listSize[index]
                            ? AppColors.black
                            : AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greyD),
                      ),
                      child: Text(
                        listSize[index],
                        style: state.size == listSize[index]
                            ? AppTextStyle.whiteS14
                            : AppTextStyle.blackS14,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
