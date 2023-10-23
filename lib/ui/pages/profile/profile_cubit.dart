import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AppCubit appCubit;
  final ProfileNavigator navigator;

  ProfileCubit({
    required this.appCubit,
    required this.navigator,
  }) : super(const ProfileState());

  Future<void> getUser() async {
    emit(
      state.copyWith(userStatus: LoadStatus.loading),
    );
    try {
      if (appCubit.state.user != null) {
        emit(state.copyWith(
          user: appCubit.state.user,
          userStatus: LoadStatus.success,
        ));
      } else {
        emit(state.copyWith(userStatus: LoadStatus.failure));
      }
    } catch (e) {
      emit(
        state.copyWith(userStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await appCubit.signOut();
      Future.delayed(const Duration(seconds: 2), () {
        emit(
          state.copyWith(signOutStatus: LoadStatus.success),
        );
        navigator.openLoginPage();
      });
    } catch (e) {
      emit(
        state.copyWith(signOutStatus: LoadStatus.failure),
      );
    }
  }
}
