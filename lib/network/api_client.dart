import 'package:dio/dio.dart';
import 'package:ecommerce/models/entities/token_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // User
  @POST("/auth/login")
  Future<TokenEntity> authLogin(@Body() Map<String, dynamic> body);
}