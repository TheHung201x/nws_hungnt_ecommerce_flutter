import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/notification/notification_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:ecommerce/ui/pages/cart/widgets/appbar_cart.dart';
import 'package:ecommerce/ui/pages/cart/widgets/item_cart.dart';
import 'package:ecommerce/ui/pages/cart/widgets/title_cart.dart';
import 'package:ecommerce/ui/pages/notification/notification_cubit.dart';
import 'package:ecommerce/ui/widgets/list/empty_list_widget.dart';
import 'package:ecommerce/ui/widgets/list/error_list_widget.dart';
import 'package:ecommerce/ui/widgets/list/loading_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
          create: (context) {
            return CartCubit(
              cartRepository: RepositoryProvider.of<CartRepository>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context),
              appNavigator: AppNavigator(context: context),
            )
              ..getAllCart();
          },
          child:
          const CartChildPage()
      );
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
    userEntity = UserEntity();
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    userRepository = RepositoryProvider.of<UserRepository>(context);
    _cartCubit = BlocProvider.of<CartCubit>(context);
    getUser();
    super.initState();
  }

  void getUser() async {
    userEntity = await userRepository.getProfile();
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
                  const AppBarCart(),
                  const TitleCart(),
                  const SizedBox(height: 20),
                  _showListCart(),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: _totalAllPriceAndCheckout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showListCart() {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height / 2 + 30,
      child: BlocBuilder<CartCubit, CartState>(
        bloc: _cartCubit,
        buildWhen: (previous, current) {
          return previous.getAllCartStatus != current.getAllCartStatus;
        },
        builder: (context, state) {
          if (state.getAllCartStatus == LoadStatus.loading) {
            return const LoadingListWidget();
          }
          if (state.getAllCartStatus == LoadStatus.failure) {
            return ErrorListWidget(
              onRefresh: () => _cartCubit.getAllCart(),
            );
          }
          final listCart = state.cartList;
          return listCart.isNotEmpty
              ? RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              _cartCubit.getAllCart();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: listCart.length,
              itemBuilder: (context, index) {
                // _cartCubit.getCart(listCart);
                return Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: ItemCart(
                    cartEntity: listCart[index],
                    index: index,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
            ),
          )
              : _emptyListCart();
        },
      ),
    );
  }

  Widget _emptyListCart() {
    return EmptyListWidget(
      text: S.current.empty_in_cart,
      linkImage: AppImages.emptyCart,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        _cartCubit.getAllCart();
      },
    );
  }

  Widget _totalAllPriceAndCheckout() {
    return BlocBuilder<CartCubit, CartState>(
      bloc: _cartCubit,
      buildWhen: (previous, current) {
        return previous.getAllCartStatus != current.getAllCartStatus;
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.current.total} (${state.cartList.length} ${S.current
                      .item})',
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
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: state.cartList.isEmpty ? null : () => checkOut(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        S.current.proceed_to_checkout,
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
    );
  }

  Future<void> checkOut() async {
    await _cartCubit.deleteAllCart(userEntity.id);
    final notificationEntity = NotificationEntity(
        idUser: userEntity.id,
        title: 'You have placed your order successfully',
        createAt: '${DateTime.now()}',
        image: userEntity.avatar);

    _notificationCubit
        .addNewNotification(notificationEntity)
        .then((value) => _notificationCubit.getAllNotifications());
  }
}
