import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({required this.authRepository}) : super(const SignInState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signIn() async {
    String email = state.email ?? '';
    String password = state.password ?? '';
    if (email.isEmpty) {
      print("user null");
      return;
    }
    if (password.isEmpty) {
      print("pass null");
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final result = await authRepository.signIn(email, password);
      debugPrint('a $result');
      emit(state.copyWith(signInStatus: LoadStatus.success));
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
