import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
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
      emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.success,categoriesList: result));
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(getCategoriesLoadStatus: LoadStatus.failure));
    }
  }
}
