import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/ui/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchCategories extends StatefulWidget {
  const SearchCategories({Key? key}) : super(key: key);

  @override
  State<SearchCategories> createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends State<SearchCategories> {
  late HomeCubit _homeCubit;
  late TextEditingController searchController;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xFFF3F4F6),
      ),
      height: 50,
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.icSearch,
            height: 20,
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  _homeCubit.searchCategories(value);
                },
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                  hintText: S.current.search_categories,
                  hintStyle: AppTextStyle.greyA14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
