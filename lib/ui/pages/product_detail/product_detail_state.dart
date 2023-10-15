part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final int quantity;
  final int color;
  final String size;
  final int price;
  final int totalPrice;
  // final LoadStatus changeQuantityStatus;
  // final LoadStatus changeSizeStatus;
  // final LoadStatus changeColorStatus;
  final LoadStatus addToCartStatus;

  const ProductDetailState({
    this.quantity = 1,
    this.color = 0,
    this.size = '',
    this.price = 0,
    this.totalPrice = 0,
    // this.changeQuantityStatus = LoadStatus.initial,
    // this.changeSizeStatus = LoadStatus.initial,
    // this.changeColorStatus = LoadStatus.initial,
    this.addToCartStatus = LoadStatus.initial,
  });

  ProductDetailState copyWith({
    int? quantity,
    int? color,
    String? size,
    int? price,
    int? totalPrice,
    // LoadStatus? changeQuantityStatus,
    // LoadStatus? changeSizeStatus,
    // LoadStatus? changeColorStatus,
    LoadStatus? addToCartStatus,
  }) {
    return ProductDetailState(
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      // changeQuantityStatus: changeQuantityStatus ?? this.changeQuantityStatus,
      // changeSizeStatus: changeSizeStatus ?? this.changeSizeStatus,
      // changeColorStatus: changeColorStatus ?? this.changeColorStatus,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
    );
  }

  @override
  List<Object?> get props => [
        quantity,
        color,
        size,
        price,
        totalPrice,
        addToCartStatus,
        // changeQuantityStatus,
        // changeSizeStatus,
        // changeColorStatus,
      ];
}
