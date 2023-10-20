import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ProductDetailCubit(
              appNavigator: AppNavigator(context: context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            final cartRepository =
                RepositoryProvider.of<CartRepository>(context);
            return CartCubit(
              cartRepository: cartRepository,
              appNavigator: AppNavigator(context: context),
            );
          },
        ),
      ],
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
  late CartCubit _cartCubit;
  late UserRepository userRepository;
  late PageController pageController;
  late UserEntity userEntity;

  @override
  void initState() {
    _cartCubit = BlocProvider.of<CartCubit>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
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
        child: Stack(
          children: [
            SliderImageProductDetail(
                pageController: pageController,
                productEntity: widget.productEntity),
            Positioned(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TitleAndRatingProductDetail(
                                productEntity: widget.productEntity),
                            QuantityProductDetail(
                              productEntity: widget.productEntity,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizeProductDetail(
                              productEntity: widget.productEntity,
                            ),
                            const AppColorsProductDetail(),
                          ],
                        ),
                        DescriptionProductDetail(
                          productEntity: widget.productEntity,
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
            AppIconButton(
              width: MediaQuery.of(context).size.width / 2,
              isContentCenter: true,
              backgroundColor: AppColors.black,
              title: 'Add to cart',
              onPressed: () {
                final cartEntity = CartEntity(
                    userEntity.id,
                    widget.productEntity,
                    widget.productEntity.images[0],
                    state.totalPrice,
                    state.quantity);
                _cartCubit.addToCart(cartEntity, context);
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
            )
          ],
        );
      },
    );
  }
}
