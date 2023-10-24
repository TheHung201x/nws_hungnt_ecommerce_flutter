part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final int quantity;
  final int color;
  final String size;
  final int price;
  final int totalPrice;
  final ProductEntity? productEntity;
  final LoadStatus getProductDetailStatus;

  const ProductDetailState({
    this.quantity = 1,
    this.color = 0,
    this.size = '',
    this.price = 0,
    this.totalPrice = 0,
    this.getProductDetailStatus = LoadStatus.initial,
    this.productEntity,
  });

  ProductDetailState copyWith({
    int? quantity,
    int? color,
    String? size,
    int? price,
    int? totalPrice,
    LoadStatus? getProductDetailStatus,
    ProductEntity? productEntity,
  }) {
    return ProductDetailState(
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      getProductDetailStatus:
          getProductDetailStatus ?? this.getProductDetailStatus,
      productEntity: productEntity ?? this.productEntity,
    );
  }

  @override
  List<Object?> get props => [
        quantity,
        color,
        size,
        price,
        totalPrice,
        getProductDetailStatus,
        productEntity,
      ];
}
