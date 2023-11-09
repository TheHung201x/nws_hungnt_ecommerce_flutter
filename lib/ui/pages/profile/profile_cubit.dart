import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AppCubit appCubit;
  final ProfileNavigator profileNavigator;

  ProfileCubit({
    required this.appCubit,
    required this.profileNavigator,
  }) : super(const ProfileState());

  Future<void> getUser() async {
    emit(state.copyWith(userStatus: LoadStatus.loading));
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
      profileNavigator.openAuthPage();
    } catch (e) {
      emit(
        state.copyWith(signOutStatus: LoadStatus.failure),
      );
    }
  }

  void handleSignOut(){
    signOut();
  }
}
