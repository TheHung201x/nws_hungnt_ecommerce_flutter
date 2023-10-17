import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:ecommerce/ui/widget/buttons/app_button.dart';
import 'package:ecommerce/ui/widget/buttons/app_icon_button.dart';
import 'package:ecommerce/ui/widget/textfields/app_email_text_field.dart';
import 'package:ecommerce/ui/widget/textfields/app_password_text_field.dart';
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
                    'Welcome!',
                    style: AppTextStyle.blackS18Bold,
                  ),
                  subtitle: Text(
                    'please login or sign up to continue our app',
                    style: AppTextStyle.greyS14,
                  ),
                  contentPadding: EdgeInsets.zero),
              const SizedBox(
                height: 20,
              ),
              AppEmailTextField(
                textEditingController: emailTextController,
                hintText: 'Please enter email',
                checkIconController: checkIconController,
                onChanged: (_) {
                  setState(() {
                    hasCheckIcon = true;
                  });
                },
                hasCheck: hasCheckIcon,
              ),
              const SizedBox(height: 10),
              AppPasswordTextField(
                textEditingController: passwordTextController,
                obscureTextController: obscurePasswordController,
                hintText: 'Please enter password',
              ),
              const SizedBox(height: 40),
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return AppButton(
                    title: 'Login',
                    onPressed: () => _signIn(),
                    isEnable:
                        state.signInStatus == LoadStatus.loading ? false : true,
                    isLoading:
                        state.signInStatus == LoadStatus.loading ? true : false,
                    backgroundColor: AppColors.black,
                    textStyle: AppTextStyle.whiteS16Bold,
                    cornerRadius: 50,
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Divider(
                      color: AppColors.border,
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('or', style: AppTextStyle.black),
                    ),
                    Expanded(
                        child: Divider(
                      color: AppColors.border,
                      thickness: 1,
                    )),
                  ],
                ),
              ),
              AppIconButton(
                leadingIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/image/ic_facebook.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                title: 'Continue with Facebook',
                onPressed: () {},
                backgroundColor: AppColors.buttonFacebook,
                textStyle: AppTextStyle.whiteS16Bold,
                cornerRadius: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppIconButton(
                  leadingIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      'assets/vectors/ic_google.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  title: 'Continue with Google',
                  onPressed: () {},
                  backgroundColor: AppColors.transparent,
                  textStyle: AppTextStyle.greyA16Bold,
                  cornerRadius: 50,
                  // borderWidth: 1,
                  // borderColor: AppColors.textWhite,
                ),
              ),
              AppIconButton(
                leadingIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    'assets/vectors/ic_apple.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                title: 'Continue with Apple',
                onPressed: () {},
                backgroundColor: AppColors.white,
                textStyle: AppTextStyle.greyA16Bold,
                cornerRadius: 50,
                // borderWidth: 1,
                // borderColor: AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
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
