import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
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
        physics: const BouncingScrollPhysics(),
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
          S.current.sign_up,
          style: AppTextStyle.blackS18Bold,
        ),
        subtitle: Text(
          S.current.sub_title_sign_up,
          style: AppTextStyle.greyS14,
        ),
        contentPadding: EdgeInsets.zero);
  }

  Widget _textFieldUserNameSignUp() {
    return AppUserNameTextField(
      labelText: S.current.username,
      textEditingController: userNameTextController,
      checkIconController: checkIconUserNameController,
      onChanged: (_) {
        setState(() {
          hasCheckIconUserName = true;
        });
      },
      hasCheck: hasCheckIconUserName,
      hintText: S.current.validate_username_empty,
    );
  }

  Widget _textFieldEmailSignUp() {
    return AppEmailTextField(
      textEditingController: emailTextController,
      checkIconController: checkIconEmailController,
      hintText: S.current.validate_email_empty,
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
      labelText: S.current.password,
      hasObscure: true,
      textEditingController: passwordTextController,
      obscureTextController: obscurePasswordController,
      hintText: S.current.validate_password_empty,
    );
  }

  Widget _textFieldConfirmPasswordSignUp() {
    return AppPasswordTextField(
      hasObscure: true,
      labelText: S.current.confirm_password,
      textTempEditingController: passwordTextController,
      textEditingController: confirmPasswordTextController,
      obscureTextController: obscureConfirmPasswordController,
      hintText: S.current.validate_password_empty,
    );
  }

  Widget _checkBoxAgree() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Checkbox(
                value: state.checkBoxAgreeSignUp,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                onChanged: (newValue) {
                  _signUpCubit.checkboxAgree(newValue!);
                },
              );
            },
          ),
          Expanded(
            child: Text(
              S.current.title_checkbox_agree_sign_up,
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
          title: S.current.sign_up,
          onPressed: () => _signUp(),
          isEnable: (state.signUpStatus == LoadStatus.loading ||
                  state.checkBoxAgreeSignUp == false)
              ? false
              : true,
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
      _signUpCubit.signUp(
        userNameTextController.text,
        emailTextController.text,
        passwordTextController.text,
      );
    }
  }
}
