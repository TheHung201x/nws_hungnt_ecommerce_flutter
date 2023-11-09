import 'dart:developer';

import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final UserRepository userRepository;
  final AppNavigator appNavigator;

  CartCubit({
    required this.cartRepository,
    required this.userRepository,
    required this.appNavigator,
  }) : super(const CartState());

  Future<void> addToCart(CartEntity cartEntity) async {
    emit(state.copyWith(addToCartStatus: LoadStatus.loading));
    try {
      await cartRepository.addToCart(
        cartEntity: cartEntity,
      );
      emit(state.copyWith(addToCartStatus: LoadStatus.success, cartList: []));
      appNavigator.showSuccessFlushbar(message: S.current.add_to_cart_success);
    } catch (e) {
      log("Error", error: e);
      emit(state.copyWith(addToCartStatus: LoadStatus.failure));
      appNavigator.showErrorFlushbar(message: S.current.add_to_cart_failed);
    }
  }

  Future<void> getAllCart() async {
    emit(state.copyWith(getAllCartStatus: LoadStatus.loading));
    try {
      UserEntity? userEntity = await userRepository.getProfile();
      final cartList = await cartRepository.getAllCart(userEntity.id);
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
        appNavigator.showSuccessFlushbar(message: S.current.checkout_success);
      });
    } catch (e) {
      emit(
        state.copyWith(getAllCartStatus: LoadStatus.failure),
      );
      appNavigator.showSuccessFlushbar(message: S.current.checkout_failed);
    }
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
      appNavigator.showErrorFlushbar(message: S.current.decrease_error);
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
