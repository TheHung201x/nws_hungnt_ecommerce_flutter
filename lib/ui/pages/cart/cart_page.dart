import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/repositories/notification_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:ecommerce/ui/pages/notification/notification_cubit.dart';
import 'package:ecommerce/ui/widgets/list/empty_list_widget.dart';
import 'package:ecommerce/ui/widgets/list/error_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) {
          return CartCubit(
              cartRepository: RepositoryProvider.of<CartRepository>(context),
              appNavigator: AppNavigator(context: context));
        },
      ),
      BlocProvider(
        create: (context) {
          return NotificationCubit(
              notificationRepository:
                  RepositoryProvider.of<NotificationRepository>(context));
        },
      )
    ], child: const CartChildPage());
  }
}

class CartChildPage extends StatefulWidget {
  const CartChildPage({Key? key}) : super(key: key);

  @override
  State<CartChildPage> createState() => _CartChildPageState();
}

class _CartChildPageState extends State<CartChildPage> {
  late CartCubit _cartCubit;
  late NotificationCubit _notificationCubit;
  late UserRepository userRepository;
  late UserEntity userEntity;

  @override
  void initState() {
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
    userEntity = UserEntity();
    _cartCubit = BlocProvider.of<CartCubit>(context);
    getUser();
    super.initState();
  }

  void getUser() async {
    userEntity = await userRepository.getProfile();
    _cartCubit.getAllCart(userEntity.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          AppImages.icBack,
                          height: 40,
                          width: 40,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            AppImages.icBag,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'My Cart',
                    style: AppTextStyle.blackS20W800,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                      if (state.getAllCartStatus == LoadStatus.success) {
                        final listCart = state.cartList;
                        return RefreshIndicator(
                          onRefresh: () async {
                            _cartCubit.getAllCart(userEntity.id);
                          },
                          child: listCart.isNotEmpty
                              ? ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    _cartCubit.getCart(listCart);
                                    return Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10.0,
                                              spreadRadius: 2.0,
                                              offset: const Offset(
                                                0,
                                                10,
                                              ),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRouter.productDetail,
                                                  extra: listCart[index]
                                                      .productEntity);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: listCart[index].image,
                                                height: 80,
                                                width: 80,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                context.pushNamed(
                                                    AppRouter.productDetail,
                                                    extra: listCart[index]
                                                        .productEntity);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    listCart[index]
                                                        .productEntity
                                                        .title,
                                                    style: AppTextStyle
                                                        .blackS16Bold,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                  Text(
                                                    listCart[index]
                                                        .productEntity
                                                        .description,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: AppTextStyle.greyS12,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '\$${listCart[index].totalPrice}',
                                                    style: AppTextStyle
                                                        .blackS18Bold,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              color: AppColors.backgroundTabBar,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                        _cartCubit.decrement(index, listCart[index].productEntity.price,);},
                                                    child: const Icon(
                                                        Icons.remove)),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text('${state.cartList[index].quantity}'
                                                      .toString()),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _cartCubit.increment(index,listCart[index].productEntity.price,);},
                                                    child:
                                                        const Icon(Icons.add)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 15,
                                    );
                                  },
                                  itemCount: listCart.length)
                              : EmptyListWidget(
                                  text: 'No products in the cart',
                                  linkImage: AppImages.emptyCart,
                                  onRefresh: () async {
                                    await _cartCubit.getAllCart(userEntity.id);
                                  }),
                        );
                      } else if (state.getAllCartStatus == LoadStatus.failure) {
                        return ErrorListWidget(
                          onRefresh: () => _cartCubit.getAllCart(userEntity.id),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total (${state.cartList.length} item)',
                              style: AppTextStyle.greyS14,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '\$${state.totalAllPrice}',
                              style: AppTextStyle.blackS18Bold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _cartCubit.deleteAllCart(userEntity.id);
                            final notificationEntity = NotificationEntity(
                                idUser: userEntity.id,
                                title:
                                    'You have placed your order successfully',
                                createAt: DateTime.now().toString(),
                                image: userEntity.avatar);
                            _notificationCubit
                                .addNewNotification(notificationEntity);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Proceed to Checkout',
                                    style: AppTextStyle.whiteS16,
                                  ),
                                ),
                                SvgPicture.asset(AppImages.icArrow)
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
