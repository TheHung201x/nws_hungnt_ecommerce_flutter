import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:ecommerce/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:ecommerce/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:ecommerce/ui/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSuccessPage extends StatelessWidget {
  final UserEntity userEntity;

  const SignUpSuccessPage({Key? key, required this.userEntity})
      : super(key: key);

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
      child: SignUpSuccessChildPage(userEntity: userEntity),
    );
  }
}

class SignUpSuccessChildPage extends StatefulWidget {
  const SignUpSuccessChildPage({Key? key, required this.userEntity})
      : super(key: key);
  final UserEntity userEntity;

  @override
  State<SignUpSuccessChildPage> createState() => _SignUpSuccessChildPageState();
}

class _SignUpSuccessChildPageState extends State<SignUpSuccessChildPage> {
  late SignUpNavigator signUpNavigator;
  late SignInCubit _signInCubit;

  @override
  void initState() {
    signUpNavigator = SignUpNavigator(context: context);
    _signInCubit = BlocProvider.of<SignInCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.success,
              height: 50,
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 200),
              child: ListTile(
                  title: Text(
                    S.current.title_success,
                    style: AppTextStyle.blackS24Bold,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    S.current.sub_title_success,
                    style: AppTextStyle.greyS14,
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: EdgeInsets.zero),
            ),
            BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                return AppButton(
                  title: S.current.start_shopping,
                  cornerRadius: 30,
                  backgroundColor: AppColors.black,
                  onPressed: () => _signInCubit.signIn(
                    widget.userEntity.email,
                    widget.userEntity.password,
                  ),
                  isEnable:
                      state.signInStatus == LoadStatus.loading ? false : true,
                  isLoading:
                      state.signInStatus == LoadStatus.loading ? true : false,
                  textStyle: AppTextStyle.whiteS16Bold,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
