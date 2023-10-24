import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:ecommerce/ui/pages/product_detail/product_detail_cubit.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/colors_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/description_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/quantity_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/size_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/slider_image_product_detail.dart';
import 'package:ecommerce/ui/pages/product_detail/widgets/title_and_rating_product_detail.dart';
import 'package:ecommerce/ui/widgets/buttons/app_icon_button.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:ecommerce/utils/app_int_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.idProduct})
      : super(key: key);

  final int idProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProductDetailCubit(
          appNavigator: AppNavigator(context: context),
          productRepository: RepositoryProvider.of<ProductRepository>(context),
        );
      },
      child: ProductDetailChildPage(idProduct: idProduct),
    );
  }
}

class ProductDetailChildPage extends StatefulWidget {
  const ProductDetailChildPage({Key? key, required this.idProduct})
      : super(key: key);
  final int idProduct;

  @override
  State<ProductDetailChildPage> createState() => _ProductDetailChildPageState();
}

class _ProductDetailChildPageState extends State<ProductDetailChildPage> {
  late CartCubit _cartCubit;
  late UserRepository userRepository;
  late PageController pageController;
  late UserEntity userEntity;
  late ProductDetailCubit _productDetailCubit;

  @override
  void initState() {
    _cartCubit = BlocProvider.of<CartCubit>(context);
    _productDetailCubit = BlocProvider.of<ProductDetailCubit>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
    _productDetailCubit.getProductDetailById(widget.idProduct);
    userEntity = UserEntity();
    getUser();
    pageController = PageController();
    super.initState();
  }

  void getUser() async {
    userEntity = await userRepository.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state.getProductDetailStatus == LoadStatus.success) {
              return Stack(
                children: [
                  SliderImageProductDetail(
                      pageController: pageController,
                      productEntity: state.productEntity!),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TitleAndRatingProductDetail(
                                      productEntity: state.productEntity!),
                                  QuantityProductDetail(
                                    productEntity: state.productEntity!,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizeProductDetail(
                                    productEntity: state.productEntity!,
                                  ),
                                  const AppColorsProductDetail(),
                                ],
                              ),
                              DescriptionProductDetail(
                                productEntity: state.productEntity!,
                              ),
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
                  )
                ],
              );
            } else {
              return const AppShimmer();
            }
          },
        ),
      ),
    );
  }

  Widget _totalPriceAndBtnAddToCart() {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
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
                  Text(
                    '\$${state.totalPrice.formatPrice}',
                    style: AppTextStyle.blackS18Bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            BlocListener<CartCubit, CartState>(
              listener: (context, state) {
               if(state.getAllCartStatus == LoadStatus.success){

               }
              },
              child: AppIconButton(
                width: MediaQuery.of(context).size.width / 2,
                isContentCenter: true,
                backgroundColor: AppColors.black,
                title: 'Add to cart',
                onPressed: () {
                  final cartEntity = CartEntity(
                      userEntity.id,
                      state.productEntity!,
                      state.productEntity!.images[0],
                      state.totalPrice,
                      state.quantity);
                  _cartCubit.addToCart(cartEntity).then((_) => _cartCubit.getAllCart());
                },
                cornerRadius: 30,
                leadingIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    AppImages.icBag,
                    color: AppColors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
