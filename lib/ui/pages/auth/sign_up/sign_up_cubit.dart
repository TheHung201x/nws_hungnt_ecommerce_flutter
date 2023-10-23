import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  final AuthRepository authRepository;

  SignUpCubit({required this.navigator, required this.authRepository})
      : super(const SignUpState());

  void signUp(String userName, String email, String password) async {
    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      await authRepository.signUp(userName, email, password);
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(signUpStatus: LoadStatus.success));
        navigator.openSignUpSuccess();
      });
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
      navigator.showErrorFlushbar(message: 'Sign Up failure');
    }
  }

  void checkboxAgree(bool check) {
    emit(state.copyWith(checkBoxAgreeSignUp: check));
  }
}
