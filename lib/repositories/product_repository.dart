import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>?> getProductsByIdCategory({required int id});

  Future<ProductEntity?> getProductDetailById({required int id});

  Future<List<ProductEntity>?> loadMoreProductsList(
      {required int id, required int limit});
}

class ProductRepositoryImpl extends ProductRepository {
  ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<List<ProductEntity>?> getProductsByIdCategory(
      {required int id}) async {
    final appService = ApiUtil.apiClient;
    final productList = await appService.getProductsByIdCategory(id);
    return productList;
  }

  @override
  Future<ProductEntity?> getProductDetailById({required int id}) async {
    final appService = ApiUtil.apiClient;
    final productDetail = await appService.getProductDetailById(id);
    return productDetail;
  }

  @override
  Future<List<ProductEntity>?> loadMoreProductsList(
      {required int id, required int limit}) async {
    final appService = ApiUtil.apiClient;
    final productList =
        await appService.getProductsLimitByIdCategory(id, limit);
    return productList;
  }
}
