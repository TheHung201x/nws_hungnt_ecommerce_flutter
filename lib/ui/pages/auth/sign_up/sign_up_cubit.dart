import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/ui/widget/dialogs/dialog_failure.dart';
import 'package:ecommerce/ui/widget/dialogs/dialog_success.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(const SignUpState());

  void changeUserName({required String userName}) {
    emit(state.copyWith(userName: userName));
  }
  
  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signUp(BuildContext context) async {
    String userName = state.userName ?? '';
    String email = state.email ?? '';
    String password = state.password ?? '';
    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      await authRepository.signUp(userName,email, password);
      emit(state.copyWith(signUpStatus: LoadStatus.success));
      showDialogSuccess(content: 'Sign Up Success',context: context);
      Future.delayed(Duration(seconds: 3), (){
        if(context.canPop()){
          context.pop();
        }
      });
    } catch (err) {
      debugPrint(' err :$err');
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
      showDialogFailure(content: 'Sign Up Failure', context: context);
      Future.delayed(Duration(seconds: 3), (){
        if(context.canPop()){
          context.pop();
        }
      });
    }
  }
}
