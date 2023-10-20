import 'package:ecommerce/models/entities/category/category_entity.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/product_list/product_list_cubit.dart';
import 'package:ecommerce/ui/pages/product_list/widgets/appbar_products_list.dart';
import 'package:ecommerce/ui/pages/product_list/widgets/item_product.dart';
import 'package:ecommerce/ui/pages/product_list/widgets/title_category.dart';
import 'package:ecommerce/ui/widgets/list/error_load_widget.dart';
import 'package:ecommerce/ui/widgets/list/loading_gridview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              const AppbarProductsList(),
              TitleCategory(nameCategory: widget.nameCategory),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _productListCubit.getProductsListByIdCategory(widget.idCategory);
                  },
                  child: BlocBuilder<ProductListCubit, ProductListState>(
                    builder: (context, state) {
                      if (state.getProductsLoadStatus == LoadStatus.success) {
                        final productList = state.productList ?? [];
                        return _showListProduct(productList);
                      } else if (state.getProductsLoadStatus ==
                          LoadStatus.failure) {
                        return ErrorLoadWidget(
                          onPress: () => _productListCubit
                              .getProductsListByIdCategory(widget.idCategory),
                        );
                      } else {
                        return const LoadingGridViewWidget();
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

  Widget _showListProduct(List<ProductEntity> productList) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        childAspectRatio: 3 / 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(AppRouter.productDetail,
                extra: productList[index]);
          },
          child: ItemProduct(productEntity: productList[index]),
        );
      },
    );
  }
}
