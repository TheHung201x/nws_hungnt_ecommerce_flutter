import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:ecommerce/ui/widgets/buttons/app_button.dart';
import 'package:ecommerce/ui/widgets/buttons/app_icon_button.dart';
import 'package:ecommerce/ui/widgets/logo/app_logo.dart';
import 'package:ecommerce/ui/widgets/textfields/app_email_text_field.dart';
import 'package:ecommerce/ui/widgets/textfields/app_password_text_field.dart';
import 'package:ecommerce/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return SignInCubit(
          navigator: SignInNavigator(context: context),
          authRepository: authRepo,
          userRepository: userRepo,
          appCubit: appCubit,
        );
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({Key? key}) : super(key: key);

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late SignInCubit _signInCubit;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late ObscureTextController obscurePasswordController;
  late CheckIconValidateController checkIconController;
  final _formKey = GlobalKey<FormState>();

  /*
   HasCheckIcon : Mặc đinh false (ko xuất hiện) icon validate ✅, khi người dùng nhập vào textfield => onchange : HasCheckIcon = true
   Lúc này icon check khi validate mới xuất hiện.
  */
  bool hasCheckIcon = false;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(text: 'john@mail.com');
    passwordTextController = TextEditingController(text: 'changeme');
    _signInCubit = BlocProvider.of<SignInCubit>(context);
    obscurePasswordController = ObscureTextController(obscureText: false);
    checkIconController = CheckIconValidateController(check: false);
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    _signInCubit.close();
    obscurePasswordController.dispose();
    checkIconController.dispose();
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
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppLogo(showingKeyboard: showingKeyboard),
              _titleLogin(),
              const SizedBox(height: 20),
              _textFieldEmailLogin(),
              const SizedBox(height: 10),
              _textFieldPasswordLogin(),
              const SizedBox(height: 40),
              _buttonLogin(),
              _textOrLogin(),
              _loginWithFacebook(),
              _loginWithGoogle(),
              _loginWithApple(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleLogin() {
    return ListTile(
        title: Text(
          S.current.title_login,
          style: AppTextStyle.blackS18Bold,
        ),
        subtitle: Text(
          S.current.sub_title_login,
          style: AppTextStyle.greyS14,
        ),
        contentPadding: EdgeInsets.zero);
  }

  Widget _textFieldEmailLogin() {
    return AppEmailTextField(
      textEditingController: emailTextController,
      hintText: S.current.validate_email_empty,
      checkIconController: checkIconController,
      onChanged: (_) {
        setState(() {
          hasCheckIcon = true;
        });
      },
      hasCheck: hasCheckIcon,
    );
  }

  Widget _textFieldPasswordLogin() {
    return AppPasswordTextField(
      textEditingController: passwordTextController,
      obscureTextController: obscurePasswordController,
      hintText: S.current.validate_password_empty,
      labelText: S.current.password,
    );
  }

  Widget _buttonLogin() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return AppButton(
          height: 50,
          title: S.current.login,
          onPressed: () => _signIn(),
          isEnable: state.signInStatus == LoadStatus.loading ? false : true,
          isLoading: state.signInStatus == LoadStatus.loading ? true : false,
          backgroundColor: AppColors.black,
          textStyle: AppTextStyle.whiteS16Bold,
          cornerRadius: 50,
        );
      },
    );
  }

  Widget _textOrLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(S.current.or, style: AppTextStyle.black),
          ),
          const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginWithFacebook() {
    return AppIconButton(
      leadingIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.asset(
          AppImages.icFacebook,
          width: 20,
          height: 20,
        ),
      ),
      title: S.current.login_with_facebook,
      onPressed: () {},
      backgroundColor: AppColors.buttonFacebook,
      textStyle: AppTextStyle.whiteS16Bold,
      cornerRadius: 50,
    );
  }

  Widget _loginWithGoogle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppIconButton(
        height: 50,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset(
            AppImages.icGoogle,
            width: 20,
            height: 20,
          ),
        ),
        title: S.current.login_with_google,
        onPressed: () {},
        backgroundColor: AppColors.white,
        textStyle: AppTextStyle.greyA16Bold,
        cornerRadius: 50,
        borderWidth: 1,
        borderColor: AppColors.border.withOpacity(0.8),
      ),
    );
  }

  Widget _loginWithApple() {
    return AppIconButton(
      height: 50,
      leadingIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          AppImages.icApple,
          width: 20,
          height: 20,
        ),
      ),
      title: S.current.login_with_apple,
      onPressed: () {},
      backgroundColor: AppColors.white,
      textStyle: AppTextStyle.greyA16Bold,
      cornerRadius: 50,
      borderWidth: 1,
      borderColor: AppColors.border.withOpacity(0.8),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      hideKeyboard(context);
      _signInCubit.signIn(
          emailTextController.text, passwordTextController.text);
    }
  }
}
