import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final AppNavigator appNavigator;

  CartCubit({
    required this.cartRepository,
    required this.appNavigator,
  }) : super(const CartState());

  Future<void> addToCart(CartEntity cartEntity, BuildContext context) async {
    emit(state.copyWith(addToCartStatus: LoadStatus.loading));
    try {
      await cartRepository.addToCart(cartEntity: cartEntity, context: context);
      emit(state.copyWith(addToCartStatus: LoadStatus.success));
    } catch (e) {
      emit(
        state.copyWith(addToCartStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> getAllCart(int id) async {
    emit(
      state.copyWith(addToCartStatus: LoadStatus.loading),
    );
    try {
      final cartList = await cartRepository.getAllCart(id);
      int totalAllPrice = 0;
      for (var e in cartList) {
        totalAllPrice += e.totalPrice;
      }
      emit(
        state.copyWith(
            getAllCartStatus: LoadStatus.success,
            cartList: cartList,
            totalAllPrice: totalAllPrice),
      );
    } catch (e) {
      emit(state.copyWith(getAllCartStatus: LoadStatus.failure, cartList: []));
    }
  }

  Future<void> deleteAllCart(int id) async {
    emit(state.copyWith(getAllCartStatus: LoadStatus.loading));
    try {
      await cartRepository.deleteAllCart(id);
      Future.delayed(const Duration(seconds: 2), () {
        emit(
          state.copyWith(
              cartList: [],
              getAllCartStatus: LoadStatus.success,
              totalAllPrice: 0),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(getAllCartStatus: LoadStatus.failure),
      );
    }
  }

  void getCart(List<CartEntity> cartList) {
    emit(state.copyWith(cartList: cartList));
  }

  void increment(int index, int price) {
    emit(state.copyWith(getAllCartStatus: LoadStatus.loading));
    var list = state.cartList;
    var quantity = state.cartList[index].quantity;
    var totalPrice = state.cartList[index].totalPrice;
    var totalAllPrice = state.totalAllPrice;
    totalAllPrice += price;
    quantity++;
    totalPrice = quantity * price;
    list.elementAt(index).quantity = quantity;
    list.elementAt(index).totalPrice = totalPrice;
    emit(
      state.copyWith(
          cartList: list,
          getAllCartStatus: LoadStatus.success,
          totalAllPrice: totalAllPrice),
    );
  }

  void decrement(int index, int price) {
    emit(state.copyWith(getAllCartStatus: LoadStatus.loading));
    var list = state.cartList;
    var quantity = state.cartList[index].quantity;
    var totalPrice = state.cartList[index].totalPrice;
    var totalAllPrice = state.totalAllPrice;
    quantity--;
    if (quantity >= 1) {
      totalAllPrice -= price;
    } else {
      quantity = 1;
      appNavigator.showErrorFlushbar(
          message: 'Cannot decrease the quantity anymore');
    }

    totalPrice = quantity * price;
    list.elementAt(index).quantity = quantity;
    list.elementAt(index).totalPrice = totalPrice;

    emit(
      state.copyWith(
          cartList: list,
          getAllCartStatus: LoadStatus.success,
          totalAllPrice: totalAllPrice),
    );
  }
}
