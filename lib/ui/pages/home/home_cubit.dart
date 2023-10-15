import 'package:ecommerce/models/entities/category_entity.dart';
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

  void getAllCategories() async {
    emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.loading));
    try {
      final result = await categoryRepository.getCategories();
      emit(state.copyWith(
        getCategoriesLoadStatus: LoadStatus.success,
        categoriesList: result,
        categoriesCopyList: result,
      ));
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.failure));
    }
  }

  void searchCategories(String search) {
    emit(
      state.copyWith(getCategoriesLoadStatus: LoadStatus.loading, searchStatus: SearchStatus.loading),
    );
    List<CategoryEntity>? categoriesList = state.categoriesCopyList;
    List<CategoryEntity>? filteredList = categoriesList
        ?.where((category) =>
            category.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    print('list1 $categoriesList');
    Future.delayed(const Duration(milliseconds: 500), (){
      if(search.isNotEmpty && filteredList!.isNotEmpty){
        emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.success,categoriesList: filteredList,searchStatus: SearchStatus.success));
      }else if(filteredList!.isEmpty){
        emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.success,categoriesList: [],searchStatus: SearchStatus.notFound));
      }
      else{
        emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.success,categoriesList: categoriesList,searchStatus: SearchStatus.success));
      }
    });
  }
}
