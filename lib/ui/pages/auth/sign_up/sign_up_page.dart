import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:ecommerce/ui/widget/buttons/app_button.dart';
import 'package:ecommerce/ui/widget/textfields/app_email_text_field.dart';
import 'package:ecommerce/ui/widget/textfields/app_password_text_field.dart';
import 'package:ecommerce/ui/widget/textfields/app_username_text_field.dart';
import 'package:ecommerce/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        return SignUpCubit(
          navigator: SignUpNavigator(context: context),
          authRepository: authRepo,
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({Key? key}) : super(key: key);

  @override
  State<SignUpChildPage> createState() => _SignUpChildPageState();
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  late SignUpCubit _signUpCubit;
  late TextEditingController userNameTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;

  late ObscureTextController obscurePasswordController;
  late ObscureTextController obscureConfirmPasswordController;

  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    userNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);

    obscurePasswordController = ObscureTextController(obscureText: false);
    obscureConfirmPasswordController =
        ObscureTextController(obscureText: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBodyWidget(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget buildBodyWidget() {
    final showingKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  height: showingKeyboard ? 0 : 100,
                  child: Image.asset(AppImages.logoFashion)),
              ListTile(
                  title: Text(
                    'Sign Up',
                    style: AppTextStyle.blackS18Bold,
                  ),
                  subtitle: Text(
                    'Create an new account',
                    style: AppTextStyle.greyS14,
                  ),
                  contentPadding: EdgeInsets.zero),
              const SizedBox(
                height: 20,
              ),
              AppUsernameTextField(
                textEditingController: userNameTextController,
                onChanged: (text) {
                  _signUpCubit.changeUserName(
                      userName: userNameTextController.text);
                },
                hintText: 'Please enter username',
              ),
              const SizedBox(height: 10),
              AppEmailTextField(
                textEditingController: emailTextController,
                onChanged: (text) {
                  _signUpCubit.changeEmail(email: emailTextController.text);
                },
                hintText: 'Please enter email',
              ),
              const SizedBox(height: 10),
              AppPasswordTextField(
                hasObscure: true,
                textEditingController: passwordTextController,
                obscureTextController: obscurePasswordController,
                onChanged: (text) {
                  _signUpCubit.changePassword(
                      password: passwordTextController.text);
                },
                hintText: 'Please enter password',
              ),
              const SizedBox(height: 10),
              AppPasswordTextField(
                hasObscure: true,
                labelText: 'Confirm Password',
                textEditingController: confirmPasswordTextController,
                obscureTextController: obscureConfirmPasswordController,
                onChanged: (text) {
                  _signUpCubit.changePassword(
                      password: passwordTextController.text);
                },
                hintText: 'Please enter confirm password',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCheck,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By creating an account you have to agree with our them & condication',
                        style: AppTextStyle.greySA12,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return AppButton(
                    title: 'Sign Up',
                    onPressed: () => _signUp(),
                    isEnable:
                        state.signUpStatus == LoadStatus.loading ? false : true,
                    isLoading:
                        state.signUpStatus == LoadStatus.loading ? true : false,
                    backgroundColor: AppColors.black,
                    textStyle: AppTextStyle.whiteS16Bold,
                    cornerRadius: 50,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      hideKeyboard(context);
      _signUpCubit.signUp(context);
    }
  }
}
