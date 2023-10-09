import 'package:ecommerce/models/entities/token_entity.dart';
import 'package:ecommerce/models/entities/user_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile({required TokenEntity token});
  Future<UserEntity> updateProfile({required UserEntity userEntity});
}

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<UserEntity> getProfile({required TokenEntity token}) async {
    final appService = ApiUtil.apiClient;
    final response = await appService.getProfile({
      'Authorization' : 'Bearer $token'
    });
    return response;
  }

  @override
  Future<UserEntity> updateProfile({required UserEntity userEntity}) async {
    return UserEntity.updateProfile(userEntity: userEntity);
  }
}