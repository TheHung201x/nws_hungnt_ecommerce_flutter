part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final String? userName;
  final String? email;
  final String? password;
  final LoadStatus signUpStatus;
  final bool checkBoxAgreeSignUp;

  const SignUpState({
    this.userName,
    this.email,
    this.password,
    this.signUpStatus = LoadStatus.initial,
    this.checkBoxAgreeSignUp = false,
  });

  @override
  List<Object?> get props =>
      [userName, email, password, signUpStatus, checkBoxAgreeSignUp];

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    LoadStatus? signUpStatus,
    bool? checkBoxAgreeSignUp,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      checkBoxAgreeSignUp: checkBoxAgreeSignUp ?? this.checkBoxAgreeSignUp,
    );
  }
}
