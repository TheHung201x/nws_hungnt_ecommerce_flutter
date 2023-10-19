import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:ecommerce/ui/widgets/buttons/app_button.dart';
import 'package:ecommerce/ui/widgets/logo/app_logo.dart';
import 'package:ecommerce/ui/widgets/textfields/app_email_text_field.dart';
import 'package:ecommerce/ui/widgets/textfields/app_password_text_field.dart';
import 'package:ecommerce/ui/widgets/textfields/app_username_text_field.dart';
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
  late CheckIconValidateController checkIconEmailController;
  late CheckIconValidateController checkIconUserNameController;
  late ObscureTextController obscurePasswordController;
  late ObscureTextController obscureConfirmPasswordController;

  final _formKey = GlobalKey<FormState>();
  bool isCheckBox = false;
  bool hasCheckIconEmail = false;
  bool hasCheckIconUserName = false;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    userNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    checkIconEmailController = CheckIconValidateController(check: false);
    checkIconUserNameController = CheckIconValidateController(check: false);
    obscurePasswordController = ObscureTextController(obscureText: false);
    obscureConfirmPasswordController =
        ObscureTextController(obscureText: false);
  }

  @override
  void dispose() {
    userNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    checkIconEmailController.dispose();
    checkIconUserNameController.dispose();
    obscurePasswordController.dispose();
    obscureConfirmPasswordController.dispose();
    super.dispose();
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
              AppLogo(showingKeyboard: showingKeyboard),
              _titleSignUp(),
              const SizedBox(height: 20),
              _textFieldUserNameSignUp(),
              const SizedBox(height: 10),
              _textFieldEmailSignUp(),
              const SizedBox(height: 10),
              _textFieldPasswordSignUp(),
              const SizedBox(height: 10),
              _textFieldConfirmPasswordSignUp(),
              _checkBoxAgree(),
              _buttonSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleSignUp() {
    return ListTile(
        title: Text(
          'Sign Up',
          style: AppTextStyle.blackS18Bold,
        ),
        subtitle: Text(
          'Create an new account',
          style: AppTextStyle.greyS14,
        ),
        contentPadding: EdgeInsets.zero);
  }

  Widget _textFieldUserNameSignUp() {
    return AppUserNameTextField(
      textEditingController: userNameTextController,
      checkIconController: checkIconUserNameController,
      onChanged: (_) {
        setState(() {
          hasCheckIconUserName = true;
        });
      },
      hasCheck: hasCheckIconUserName,
      hintText: 'Please enter username',
    );
  }

  Widget _textFieldEmailSignUp() {
    return AppEmailTextField(
      textEditingController: emailTextController,
      checkIconController: checkIconEmailController,
      hintText: 'Please enter email',
      onChanged: (_) {
        setState(() {
          hasCheckIconEmail = true;
        });
      },
      hasCheck: hasCheckIconEmail,
    );
  }

  Widget _textFieldPasswordSignUp() {
    return AppPasswordTextField(
      hasObscure: true,
      textEditingController: passwordTextController,
      obscureTextController: obscurePasswordController,
      hintText: 'Please enter password',
    );
  }

  Widget _textFieldConfirmPasswordSignUp() {
    return AppPasswordTextField(
      hasObscure: true,
      labelText: 'Confirm Password',
      textTempEditingController: passwordTextController,
      textEditingController: confirmPasswordTextController,
      obscureTextController: obscureConfirmPasswordController,
      hintText: 'Please enter confirm password',
    );
  }

  Widget _checkBoxAgree() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Checkbox(
            value: isCheckBox,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            onChanged: (newValue) {
              setState(() {
                isCheckBox = !isCheckBox;
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
    );
  }

  Widget _buttonSignUp() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return AppButton(
          title: 'Sign Up',
          onPressed: () => _signUp(),
          isEnable: state.signUpStatus == LoadStatus.loading ? false : true,
          isLoading: state.signUpStatus == LoadStatus.loading ? true : false,
          backgroundColor: AppColors.black,
          textStyle: AppTextStyle.whiteS16Bold,
          cornerRadius: 50,
        );
      },
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      hideKeyboard(context);
      _signUpCubit.signUp(userNameTextController.text, emailTextController.text,
          passwordTextController.text);
    }
  }
}
