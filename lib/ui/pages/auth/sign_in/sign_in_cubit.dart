import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInNavigator navigator;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final AppCubit appCubit;

  SignInCubit({required this.navigator,required this.authRepository,
    required this.userRepository,
    required this.appCubit
  }) : super(const SignInState());

  void signIn(String email, String pass) async {
    emit(state.copyWith(signInStatus: LoadStatus.loading));

    try {
      final result = await authRepository.signIn(email, pass);
      if (result != null) {
        await authRepository.saveToken(result);
        UserEntity? myProfile = await userRepository.getProfile();
        appCubit.updateProfile(myProfile);
        print("my profile $myProfile");
        emit(state.copyWith(signInStatus: LoadStatus.success));
        navigator.showSuccessFlushbar(message: 'Login success');
        navigator.openHomePage();
      } else {
        navigator.showErrorFlushbar(
            message: 'An error occurred, please try again');
        emit(state.copyWith(signInStatus: LoadStatus.failure));
      }
    } catch (err) {
      navigator.showErrorFlushbar(message: 'Incorrect Email or Password');
      debugPrint(' err :$err');
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
