import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/category/category_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/models/enums/search_status.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/home/home_cubit.dart';
import 'package:ecommerce/ui/pages/home/widgets/appbar_home.dart';
import 'package:ecommerce/ui/pages/home/widgets/item_category.dart';
import 'package:ecommerce/ui/pages/home/widgets/search_categories.dart';
import 'package:ecommerce/ui/pages/home/widgets/search_category_not_found.dart';
import 'package:ecommerce/ui/widgets/list/empty_list_widget.dart';
import 'package:ecommerce/ui/widgets/list/error_load_widget.dart';
import 'package:ecommerce/ui/widgets/list/loading_gridview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeChildPage();
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({Key? key}) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }
  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
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
              const AppBarHome(),
              const SearchCategories(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    _homeCubit.getAllCategories();
                  },
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) {
                      return previous.getCategoriesLoadStatus !=
                              current.getCategoriesLoadStatus ||
                          previous.categoriesList != current.categoriesList ||
                          previous.searchStatus != current.searchStatus;
                    },
                    builder: (context, state) {
                      if (state.searchStatus == SearchStatus.notFound) {
                        return const Center(
                          child: SearchCategoryNotFound(),
                        );
                      }
                      if (state.getCategoriesLoadStatus == LoadStatus.success) {
                        return _showListCategories(state.categoriesList ?? []);
                      } else if (state.getCategoriesLoadStatus ==
                          LoadStatus.failure) {
                        return ErrorLoadWidget(
                          onPress: () => _homeCubit.getAllCategories(),
                        );
                      } else {
                        return const LoadingGridViewWidget();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showListCategories(List<CategoryEntity> categoriesList) {
    return categoriesList.isNotEmpty
        ? GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: categoriesList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              childAspectRatio: 3 / 3.3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(AppRouter.productList,
                      extra: categoriesList[index]);
                },
                child: ItemCategory(
                  categoryEntity: categoriesList[index],
                ),
              );
            },
          )
        : _emptyListCategories();
  }

  Widget _emptyListCategories() {
    return EmptyListWidget(
      text: S.current.empty_categories,
      linkImage: AppImages.emptyCategory,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        _homeCubit.getAllCategories();
      },
    );
  }
}
