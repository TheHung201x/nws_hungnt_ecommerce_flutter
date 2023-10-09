part of 'product_list_cubit.dart';

class ProductListState extends Equatable{
  final LoadStatus getProductsLoadStatus;
  final List<ProductEntity>? productList;

  const ProductListState({
    this.getProductsLoadStatus = LoadStatus.initial,
    this.productList = const [],
  });

  @override
  List<Object?> get props => [getProductsLoadStatus, productList];

  ProductListState copyWith({
    LoadStatus? getProductsLoadStatus,
    List<ProductEntity>? productList,
  }) {
    return ProductListState(
        getProductsLoadStatus:
        getProductsLoadStatus ?? this.getProductsLoadStatus,
        productList: productList ?? this.productList);
  }
}
