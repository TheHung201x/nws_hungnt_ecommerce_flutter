import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final AppNavigator appNavigator;
  final ProductRepository productRepository;

  ProductDetailCubit({
    required this.appNavigator,
    required this.productRepository,
  }) : super(const ProductDetailState());

  Future<void> getProductDetailById(int id) async {
    emit(state.copyWith(getProductDetailStatus: LoadStatus.loading));
    try {
      final product = await productRepository.getProductDetailById(id: id);
      emit(state.copyWith(
          getProductDetailStatus: LoadStatus.success, productEntity: product));
    } catch (err) {
      emit(state.copyWith(getProductDetailStatus: LoadStatus.failure));
    }
  }

  void getQuantityAndTotalPrice(int price) {
    emit(state.copyWith(price: price, totalPrice: price));
  }

  void increment() {
    emit(
      state.copyWith(
        quantity: state.quantity + 1,
        totalPrice: (state.quantity + 1) * state.price,
      ),
    );
  }

  void decrement() {
    if (state.quantity > 1) {
      emit(
        state.copyWith(
          quantity: state.quantity - 1,
          totalPrice: (state.quantity - 1) * state.price,
        ),
      );
    } else {
      emit(
        state.copyWith(
          quantity: 1,
          totalPrice: state.price * state.quantity,
        ),
      );
      appNavigator.showErrorFlushbar(
          message: 'Cannot decrease the quantity anymore');
    }
  }

  void chooseSizeProduct(String size) {
    emit(state.copyWith(size: size));
  }

  void chooseColorProduct(int color) {
    emit(state.copyWith(color: color));
  }
}
