import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final AppNavigator appNavigator;

  ProductDetailCubit({required this.appNavigator})
      : super(const ProductDetailState());

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
