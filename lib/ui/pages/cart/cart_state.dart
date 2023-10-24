part of 'cart_cubit.dart';

class CartState extends Equatable {
  final LoadStatus getAllCartStatus;
  final List<CartEntity> cartList;
  final int totalAllPrice;

  const CartState({
    this.getAllCartStatus = LoadStatus.initial,
    this.cartList = const [],
    this.totalAllPrice = 0,
  });

  CartState copyWith({
    LoadStatus? getAllCartStatus,
    List<CartEntity>? cartList,
    int? totalAllPrice,
  }) {
    return CartState(
      getAllCartStatus: getAllCartStatus ?? this.getAllCartStatus,
      cartList: cartList ?? this.cartList,
      totalAllPrice: totalAllPrice ?? this.totalAllPrice,
    );
  }

  @override
  List<Object?> get props => [
        cartList,
        getAllCartStatus,
        totalAllPrice,
      ];
}
