import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepository;
  AuthRepository authRepository;

  AppCubit({
    required this.userRepository,
    required this.authRepository,
  }) : super(const AppState());

  Future<void> getProfile() async {
    try {
      final result = await userRepository.getProfile();
      emit(
        state.copyWith(
          user: result,
          getProfileStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(getProfileStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(
      state.copyWith(updateProfileStatus: LoadStatus.loading),
    );
    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );
      final result = await userRepository.updateProfile(userEntity: user);
      emit(
        state.copyWith(
          user: result,
          updateProfileStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(signOutStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> signOut() async {
    emit(
      state.copyWith(signOutStatus: LoadStatus.loading),
    );
    try {
      await authRepository.removeToken();
      emit(
        state.removeUser().copyWith(signOutStatus: LoadStatus.success),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(signOutStatus: LoadStatus.failure),
      );
    }
  }
}
