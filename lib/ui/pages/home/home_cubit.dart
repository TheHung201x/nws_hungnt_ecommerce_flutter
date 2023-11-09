import 'package:ecommerce/models/entities/category/category_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/models/enums/search_status.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository categoryRepository;

  HomeCubit({required this.categoryRepository}) : super(const HomeState());

  Future<void> getAllCategories() async {
    emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.loading));
    try {
      final result = await categoryRepository.getCategories();
      emit(
        state.copyWith(
          getCategoriesLoadStatus: LoadStatus.success,
          categoriesList: result,
          categoriesCopyList: result,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(getCategoriesLoadStatus: LoadStatus.failure),
      );
      debugPrint(' err :$err');
    }
  }

  void searchCategories(String textSearch) {
    emit(state.copyWith(searchStatus: SearchStatus.loading,));
    List<CategoryEntity>? filteredList = state.categoriesCopyList
        ?.where(
          (category) =>
              category.name.toLowerCase().contains(textSearch.toLowerCase()),
        )
        .toList();

      if (textSearch.isNotEmpty && filteredList!.isNotEmpty) {
        emit(
          state.copyWith(
            getCategoriesLoadStatus: LoadStatus.success,
            categoriesList: filteredList,
            searchStatus: SearchStatus.success,
          ),
        );
      } else if (filteredList!.isEmpty) {
        emit(
          state.copyWith(
              getCategoriesLoadStatus: LoadStatus.success,
              categoriesList: [],
              searchStatus: SearchStatus.notFound),
        );
      } else {
        emit(
          state.copyWith(
              getCategoriesLoadStatus: LoadStatus.success,
              categoriesList: state.categoriesCopyList,
              searchStatus: SearchStatus.success),
        );
      }
  }
}
