import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>?> getCategories();
}

class CategoryRepositoryImpl extends CategoryRepository {
  ApiClient apiClient;

  CategoryRepositoryImpl({required this.apiClient});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final appService = ApiUtil.apiClient;
    List<CategoryEntity> categoryList = await appService.getAllCategories();
    final getTotalProduct =
        categoryList.map((e) => apiClient.getTotalProductByIdCategory(e.id));

    final productCountingList = await Future.wait(getTotalProduct);
    for (int categoryIndex = 0;
        categoryIndex < categoryList.length;
        categoryIndex++) {
      categoryList[categoryIndex].totalProduct =
          productCountingList[categoryIndex];
    }
    categoryList =
        categoryList.where((element) => element.totalProduct != 0).toList();
    return categoryList;
  }

}
