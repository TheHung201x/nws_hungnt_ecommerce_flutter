import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>?> getProductsByIdCategory({required int id});
}

class ProductRepositoryImpl extends ProductRepository {
  ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<List<ProductEntity>?> getProductsByIdCategory(
      {required int id}) async {
    final appService = ApiUtil.apiClient;
    final productList = await appService.getProductByIdCategory(id);
    return productList;
  }

}