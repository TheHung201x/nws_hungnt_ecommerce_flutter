part of 'cart_cubit.dart';

class CartState extends Equatable {
  final LoadStatus addToCartStatus;
  final LoadStatus getAllCartStatus;
  final LoadStatus deleteAllCartStatus;
  final List<CartEntity> cartList;
  final int totalAllPrice;

  const CartState({
    this.addToCartStatus = LoadStatus.initial,
    this.getAllCartStatus = LoadStatus.initial,
    this.deleteAllCartStatus = LoadStatus.initial,
    this.cartList = const [],
    this.totalAllPrice = 0,
  });

  CartState copyWith({
    LoadStatus? addToCartStatus,
    LoadStatus? getAllCartStatus,
    LoadStatus? deleteAllCartStatus,
    List<CartEntity>? cartList,
    int? totalAllPrice
  }) {
    return CartState(
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      getAllCartStatus: getAllCartStatus ?? this.getAllCartStatus,
      deleteAllCartStatus: deleteAllCartStatus ?? this.deleteAllCartStatus,
      cartList: cartList ?? this.cartList,
      totalAllPrice: totalAllPrice ?? this.totalAllPrice,
    );
  }

  @override
  List<Object?> get props => [addToCartStatus,cartList,getAllCartStatus,totalAllPrice, deleteAllCartStatus];
}
