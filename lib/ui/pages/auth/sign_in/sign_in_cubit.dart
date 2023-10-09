import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/database/secure_storage_helper.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInNavigator navigator;
  final AuthRepository authRepository;

  SignInCubit({required this.navigator,required this.authRepository}) : super(const SignInState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signIn(BuildContext context) async {
    String email = state.email ?? '';
    String password = state.password ?? '';
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final result = await authRepository.signIn(email, password);
        print('resp ${result}');
      if (result != null) {
        // UserEntity? myProfile = await userRepo.getProfile();
        // appCubit.updateProfile(myProfile);
        authRepository.saveToken(result);
        final token = await SecureStorageHelper.instance.getToken();
        print('token $token');
        emit(state.copyWith(signInStatus: LoadStatus.success));
        navigator.openMainPage();
      } else {
        emit(state.copyWith(signInStatus: LoadStatus.failure));
      }
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
