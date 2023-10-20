import 'package:ecommerce/database/secure_storage_helper.dart';
import 'package:ecommerce/models/entities/token/token_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String email, String password);

  Future<UserEntity?> signUp(String name, String email, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<TokenEntity?> signIn(String email, String password) async {
    final appService = ApiUtil.apiClient;
    final response = await appService.authLogin({
      'email': email,
      'password': password,
    });
    return response;
  }

  @override
  Future<UserEntity?> signUp(String name, String email, String password) async {
    final appService = ApiUtil.apiClient;
    final response = await appService.authSignUp(
      {
        'name': name,
        'email': email,
        'password': password,
        // set avatar default
        'avatar':
            'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'
      },
    );

    return response;
  }
}
