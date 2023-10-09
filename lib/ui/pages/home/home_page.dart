import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/home/home_cubit.dart';
import 'package:ecommerce/ui/widget/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final categoryRepo = RepositoryProvider.of<CategoryRepository>(context);
        return HomeCubit(categoryRepository: categoryRepo);
      },
      child: const HomeChildPage(),
    );
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
    _homeCubit.getAllCategories();
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
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: SvgPicture.asset(
                  "assets/vectors/ic_back_appbar.svg",
                  height: 40,
                  width: 40,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFF3F4F6),
                ),
                height: 50,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.search,
                      height: 20,
                      width: 20,
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Search Category',
                            hintStyle: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    _homeCubit.getAllCategories();
                  },
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.getCategoriesLoadStatus == LoadStatus.success) {
                        return GridView.builder(
                          itemCount: state.categoriesList?.length,
                          gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                                childAspectRatio: 3/3.3,
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                context.pushNamed(AppRouter.productList,extra: state.categoriesList?[index]);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    child: CachedNetworkImage(
                                      height: MediaQuery.of(context).size.height,
                                      imageUrl:
                                      state.categoriesList?[index].image ??
                                          AppImages.imageDefault,
                                      placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.network(AppImages.imageDefault),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.textWhite.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${state.categoriesList?[index].name}',
                                            style: AppTextStyle.blackS20W800,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${state.categoriesList?[index].totalProduct} Product',
                                            style: AppTextStyle.blackS18W500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state.getCategoriesLoadStatus ==
                          LoadStatus.failure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Something went wrong...'),
                              ElevatedButton(
                                  onPressed: () => _homeCubit.getAllCategories(),
                                  child: const Text('Try again'))
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: AppCircularProgressIndicator(
                              color: AppColors.textWhite),
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
