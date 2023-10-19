import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppColorsProductDetail extends StatefulWidget {
  const AppColorsProductDetail({Key? key}) : super(key: key);

  @override
  State<AppColorsProductDetail> createState() => _AppColorsProductDetailState();
}

class _AppColorsProductDetailState extends State<AppColorsProductDetail> {
  late List<int> listColors;
  late ProductDetailCubit _productDetailCubit;

  @override
  void initState() {
    listColors = [0xFFCCCCCC, 0xFF000000, 0xFFCADCA7, 0xFFF79F1F];
    _productDetailCubit = BlocProvider.of<ProductDetailCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shrinkWrap: true,
              itemCount: listColors.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _productDetailCubit.chooseColorProduct(listColors[index]);
                  },
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(listColors[index]),
                        ),
                        color: listColors[index] == 0xFFCCCCCC
                            ? AppColors.white
                            : Color(listColors[index]),
                        shape: BoxShape.circle),
                    child: state.color == listColors[index]
                        ? Icon(
                      Icons.check,
                      size: 16,
                      color: state.color == 0xFF000000
                          ? AppColors.white
                          : AppColors.black,
                    )
                        : const SizedBox.shrink(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 5,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
