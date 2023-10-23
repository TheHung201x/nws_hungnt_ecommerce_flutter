import 'package:dio/dio.dart';
import 'package:ecommerce/models/entities/category/category_entity.dart';
import 'package:ecommerce/models/entities/product/product_entity.dart';
import 'package:ecommerce/models/entities/token/token_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Login
  @POST("/auth/login")
  Future<TokenEntity> authLogin(@Body() Map<String, dynamic> body);

  // Sign Up
  @POST("/users/")
  Future<UserEntity> authSignUp(@Body() Map<String, dynamic> body);

  // Get all categories
  @GET("/categories?offset")
  Future<List<CategoryEntity>> getAllCategories();

  // Get list products by idCategory
  @GET("/categories/{id}/products?offset=0&limit=10")
  Future<List<ProductEntity>> getProductsByIdCategory(
    @Path('id') int id,
  );

  // Get list products by idCategory limit
  @GET("/categories/{id}/products?offset=0&limit={limit}")
  Future<List<ProductEntity>> getProductsLimitByIdCategory(
      @Path('id') int id,
      @Path('limit') int limit,
      );

  // Get totalProducts by idCategory
  @GET("/categories/{id}/products")
  Future<int> getTotalProductByIdCategory(
    @Path('id') int id,
  );

  // Profile
  @GET("/auth/profile")
  Future<UserEntity> getProfile();
}
