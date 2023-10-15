import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/product_list/product_list_cubit.dart';
import 'package:ecommerce/ui/widget/app_circular_progress_indicator.dart';
import 'package:ecommerce/utils/app_int_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key, required this.categoryEntity})
      : super(key: key);

  final CategoryEntity categoryEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productRepo = RepositoryProvider.of<ProductRepository>(context);
        return ProductListCubit(productRepository: productRepo);
      },
      child: ProductListChildPage(
          idCategory: categoryEntity.id, nameCategory: categoryEntity.name),
    );
  }
}

class ProductListChildPage extends StatefulWidget {
  const ProductListChildPage(
      {Key? key, required this.idCategory, required this.nameCategory})
      : super(key: key);
  final int idCategory;
  final String nameCategory;

  @override
  State<ProductListChildPage> createState() => _ProductListChildPageState();
}

class _ProductListChildPageState extends State<ProductListChildPage> {
  late ProductListCubit _productListCubit;

  @override
  void initState() {
    _productListCubit = BlocProvider.of<ProductListCubit>(context);
    _productListCubit.getProductsListByIdCategory(widget.idCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        AppImages.back,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        AppImages.search,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.nameCategory,
                  style: AppTextStyle.blackS20W800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    _productListCubit
                        .getProductsListByIdCategory(widget.idCategory);
                  },
                  child: BlocBuilder<ProductListCubit, ProductListState>(
                    builder: (context, state) {
                      if (state.getProductsLoadStatus == LoadStatus.success) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.productList?.length,
                          gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 2,
                            childAspectRatio: 3/5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRouter.productDetail,
                                    extra: state.productList?[index]);
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            imageUrl: state
                                                .productList![index].images[0],
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.network(
                                                    AppImages.imageDefault),
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 16,
                                            right: 16,
                                            child: SvgPicture.asset(
                                              AppImages.favouriteBlack,
                                              width: 26,
                                              height: 26,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${state.productList?[index].title}',
                                    style: AppTextStyle.blackS18Bold,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      '${state.productList?[index].description}',
                                      style: AppTextStyle.greyS12W800,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '\$${state.productList?[index].price.formatPrice}',
                                    style: AppTextStyle.blackS18Bold,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state.getProductsLoadStatus ==
                          LoadStatus.failure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Something went wrong...'),
                              ElevatedButton(
                                onPressed: () => _productListCubit
                                    .getProductsListByIdCategory(
                                        widget.idCategory),
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: AppCircularProgressIndicator(
                              color: AppColors.white),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
