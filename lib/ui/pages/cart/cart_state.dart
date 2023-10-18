part of 'cart_cubit.dart';

class CartState extends Equatable {
  final LoadStatus addToCartStatus;
  final LoadStatus getAllCartStatus;
  final List<CartEntity> cartList;
  final int totalAllPrice;
  // final List<int> quantity;
  // final List<int> price;
  // final List<int> totalPrice;

  const CartState({
    this.addToCartStatus = LoadStatus.initial,
    this.getAllCartStatus = LoadStatus.initial,
    this.cartList = const [],
    this.totalAllPrice = 0,
    // this.quantity = const [],
    // this.price = const [],
    // this.totalPrice = const [],
  });

  CartState copyWith({
    LoadStatus? addToCartStatus,
    LoadStatus? getAllCartStatus,
    List<CartEntity>? cartList,
    int? totalAllPrice,
    CartEntity? cartEntity,
    // List<int>? quantity,
    // List<int>? price,
    // List<int>? totalPrice,
  }) {
    return CartState(
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      getAllCartStatus: getAllCartStatus ?? this.getAllCartStatus,
      cartList: cartList ?? this.cartList,
      totalAllPrice: totalAllPrice ?? this.totalAllPrice,
      // quantity: quantity ?? this.quantity,
      // price: price ?? this.price,
      // totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        addToCartStatus,
        cartList,
        getAllCartStatus,
        totalAllPrice,
        // quantity,
        // price,
        // totalPrice,
      ];
}
