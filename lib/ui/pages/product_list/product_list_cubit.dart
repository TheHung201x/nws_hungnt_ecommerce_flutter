import 'package:ecommerce/models/entities/product_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository productRepository;

  ProductListCubit({required this.productRepository})
      : super(const ProductListState());

  void getProductsListByIdCategory(int idCategory) async {
    emit(state.copyWith(getProductsLoadStatus: LoadStatus.loading));
    try {
      final result =
          await productRepository.getProductsByIdCategory(id: idCategory);
      emit(state.copyWith(
          getProductsLoadStatus: LoadStatus.success, productList: result));
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(getProductsLoadStatus: LoadStatus.failure));
    }
  }
}