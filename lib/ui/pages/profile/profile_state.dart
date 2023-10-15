import 'package:ecommerce/models/entities/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final LoadStatus signOutStatus;
  final LoadStatus userStatus;
  final UserEntity? user;

  const ProfileState({
    this.userStatus = LoadStatus.initial,
    this.user,
    this.signOutStatus = LoadStatus.initial,
  });

  ProfileState copyWith({
    LoadStatus? signOutStatus,
    UserEntity? user,
    LoadStatus? userStatus,
  }) {
    return ProfileState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  @override
  List<Object?> get props => [
    signOutStatus,
    user,
    userStatus,
  ];
}