part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final String? userName;
  final String? email;
  final String? password;
  final LoadStatus signUpStatus;

  const SignUpState({
    this.userName,
    this.email,
    this.password,
    this.signUpStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    userName,
    email,
    password,
    signUpStatus,
  ];

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    LoadStatus? signUpStatus,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}
