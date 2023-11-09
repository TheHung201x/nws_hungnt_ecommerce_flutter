import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/cart/cart_cubit.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItemCart extends StatefulWidget {
  final CartEntity cartEntity;
  final int index;

  const ItemCart({Key? key, required this.cartEntity, required this.index})
      : super(key: key);

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  late CartCubit _cartCubit;

  @override
  void initState() {
    _cartCubit = BlocProvider.of<CartCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRouter.productDetail,
                extra: widget.cartEntity.productEntity.id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: widget.cartEntity.image,
              height: 80,
              width: 80,
              placeholder: (context, url) => const AppShimmer(),
              errorWidget: (context, url, error) =>
                  Image.network(AppImages.imageDefaultNetwork),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.pushNamed(AppRouter.productDetail,
                  extra: widget.cartEntity.productEntity);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartEntity.productEntity.title,
                  style: AppTextStyle.blackS16Bold,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  widget.cartEntity.productEntity.description,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: AppTextStyle.greyS12,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${widget.cartEntity.totalPrice}',
                  style: AppTextStyle.blackS18Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  _cartCubit.decrement(
                    widget.index,
                    widget.cartEntity.productEntity.price,
                  );
                },
                child: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text('${widget.cartEntity.quantity}'.toString()),
              ),
              GestureDetector(
                onTap: () {
                  _cartCubit.increment(
                    widget.index,
                    widget.cartEntity.productEntity.price,
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        )
      ],
    );
  }
}
