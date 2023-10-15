import 'package:dio/dio.dart';
import 'package:ecommerce/models/entities/category_entity.dart';
import 'package:ecommerce/models/entities/product_entity.dart';
import 'package:ecommerce/models/entities/token_entity.dart';
import 'package:ecommerce/models/entities/user_entity.dart';
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
  @GET("/categories?offset=0&limit=10")
  Future<List<CategoryEntity>> getAllCategories();

  // Get list product by idCategory
  @GET("/categories/{id}/products")
  Future<List<ProductEntity>> getProductByIdCategory(
    @Path('id') int id,
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
