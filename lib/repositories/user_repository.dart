import 'package:ecommerce/models/entities/user_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';
import 'package:flutter/cupertino.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();

  Future<UserEntity> updateProfile({required UserEntity userEntity});
}

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<UserEntity> getProfile() async {
    try {
      final appService = ApiUtil.apiClient;
      final response = appService.getProfile();
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return UserEntity();
    }
  }

  @override
  Future<UserEntity> updateProfile({required UserEntity userEntity}) async {
    return UserEntity.updateProfile(userEntity: userEntity);
  }
}
