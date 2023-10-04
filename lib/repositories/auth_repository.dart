import 'package:ecommerce/database/secure_storage_helper.dart';
import 'package:ecommerce/models/entities/token_entity.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String email, String password);
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
    await Future.delayed(const Duration(seconds: 2));
    final appService = ApiUtil.apiClient;
    final response = await appService.authLogin({
      'email': email,
      'password': password,
    });
    return TokenEntity(
        accessToken: response.accessToken, refreshToken: response.refreshToken);
  }
}
