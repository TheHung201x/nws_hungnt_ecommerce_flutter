import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_cubit.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/app_bar_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/dot_indicator_image_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/images_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/title_and_rating_product_detail.dart';
import 'package:ecommerce/ui/widget/buttons/app_icon_button.dart';
import 'package:ecommerce/utils/app_int_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.productEntity})
      : super(key: key);

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProductDetailCubit(appNavigator: AppNavigator(context: context));
      },
      child: ProductDetailChildPage(
        productEntity: productEntity,
      ),
    );
  }
}

class ProductDetailChildPage extends StatefulWidget {
  const ProductDetailChildPage({Key? key, required this.productEntity})
      : super(key: key);
  final ProductEntity productEntity;

  @override
  State<ProductDetailChildPage> createState() => _ProductDetailChildPageState();
}

class _ProductDetailChildPageState extends State<ProductDetailChildPage> {
  late PageController pageController;
  late int quantityProduct;
  late List<String> listSize;
  late List<int> listColors;
  late ProductDetailCubit _productDetailCubit;

  @override
  void initState() {
    pageController = PageController();
    listSize = ['S', 'M', 'L', 'XL', 'XXL'];
    listColors = [0xFFCCCCCC, 0xFF000000, 0xFFCADCA7, 0xFFF79F1F];
    _productDetailCubit = BlocProvider.of<ProductDetailCubit>(context);
    _productDetailCubit.getQuantityAndTotalPrice(widget.productEntity.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _sliderImageProductDetail(),
            _contentProductDetail(),
          ],
        ),
      ),
    );
  }

  Widget _sliderImageProductDetail() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2 + 100,
      child: Stack(
        children: [
          ImageProductDetail(
              productEntity: widget.productEntity, controller: pageController),
          const Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: AppBarProductDetail(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: SvgPicture.asset(
              AppImages.favouriteWhite,
              height: 30,
              width: 30,
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: DotIndicatorProductDetail(
                productEntity: widget.productEntity,
                controller: pageController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentProductDetail() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleAndRatingProductDetail(
                          productEntity: widget.productEntity),
                    ),
                    _quantityProduct()
                  ],
                ),
                Row(
                  children: [
                    _sizeProduct(),
                    _listColorsProduct(),
                  ],
                ),
                _descriptionProduct(),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: _totalPriceAndBtnAddToCart(),
            )
          ],
        ),
      ),
    );
  }

  Widget _quantityProduct() {
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

  Widget _sizeProduct() {
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
              return
                  GestureDetector(
                      onTap: (){
                        _productDetailCubit.chooseSizeProduct(listSize[index]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: state.size == listSize[index] ? AppColors.black : AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyD),
                        ),
                        child: Text(
                          listSize[index],
                          style: state.size == listSize[index] ? AppTextStyle.whiteS14 :AppTextStyle.blackS14,
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

  Widget _listColorsProduct() {
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

  Widget _descriptionProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.blackS18Bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            widget.productEntity.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.greyA12,
          ),
        ),
      ],
    );
  }

  Widget _totalPriceAndBtnAddToCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: AppTextStyle.greyS12,
              ),
              BlocBuilder<ProductDetailCubit, ProductDetailState>(
                builder: (context, state) {
                  return Text(
                    '\$${state.totalPrice.formatPrice}',
                    style: AppTextStyle.blackS18Bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              )
            ],
          ),
        ),
        AppIconButton(
          width: MediaQuery.of(context).size.width / 2,
          isContentCenter: true,
          backgroundColor: AppColors.black,
          title: 'Add to cart',
          onPressed: () {},
          cornerRadius: 30,
          leadingIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              AppImages.bag,
              color: AppColors.white,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
