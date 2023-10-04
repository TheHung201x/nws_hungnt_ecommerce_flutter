part of 'sign_in_cubit.dart';

class SignInState extends Equatable{
  final String? email;
  final String? password;
  final LoadStatus signInStatus;

  const SignInState({
    this.email,
    this.password,
    this.signInStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    signInStatus,
    email,
    password,
  ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? email,
    String? password,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

