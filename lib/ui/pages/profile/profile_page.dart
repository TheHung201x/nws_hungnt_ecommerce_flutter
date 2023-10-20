import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/ui/pages/profile/profile_cubit.dart';
import 'package:ecommerce/ui/pages/profile/profile_navigator.dart';
import 'package:ecommerce/ui/pages/profile/profile_state.dart';
import 'package:ecommerce/ui/pages/profile/widgets/edit_avatar_user_profile.dart';
import 'package:ecommerce/ui/pages/profile/widgets/gender_user_profile.dart';
import 'package:ecommerce/ui/pages/profile/widgets/icon_other.dart';
import 'package:ecommerce/ui/widgets/buttons/app_icon_button.dart';
import 'package:ecommerce/ui/widgets/list/error_list_widget.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:ecommerce/ui/widgets/textfields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return ProfileCubit(
          appCubit: appCubit,
          navigator: ProfileNavigator(context: context),
        );
      },
      child: const ProfileChildPage(),
    );
  }
}

class ProfileChildPage extends StatefulWidget {
  const ProfileChildPage({Key? key}) : super(key: key);

  @override
  State<ProfileChildPage> createState() => _ProfileChildPageState();
}

class _ProfileChildPageState extends State<ProfileChildPage> {
  late ProfileCubit _profileCubit;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late ProfileNavigator _navigator;

  @override
  void initState() {
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.getUser();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    _navigator = ProfileNavigator(context: context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.userStatus == LoadStatus.failure) {
              return ErrorListWidget(
                onRefresh: () => _profileCubit.getUser(),
              );
            } else if (state.userStatus == LoadStatus.success) {
              _nameController.text = state.user?.name ?? '';
              _emailController.text = state.user?.email ?? '';
              _ageController.text = '20 Year';
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      EditAvatarUserProfile(
                        avatarUser: state.user?.avatar ?? '',
                      ),
                      _nameUser(),
                      const GenderUserProfile(),
                      _ageUser(),
                      _emailUser(),
                      _groupOptions(),
                      _buttonLogout(),
                    ],
                  ),
                ),
              );
            } else if (state.signOutStatus == LoadStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const AppShimmer();
            }
          },
        ),
      ),
    );
  }

  Widget _nameUser() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Row(
        children: [
          Text(
            'Name',
            style: AppTextStyle.greyABold,
          ),
          const Spacer(),
          AppTextField(
            textEditingController: _nameController,
            hintText: 'Name',
          )
        ],
      ),
    );
  }

  Widget _ageUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Text(
            'Age',
            style: AppTextStyle.greyABold,
          ),
          const Spacer(),
          AppTextField(
            textEditingController: _ageController,
            hintText: 'Age',
          )
        ],
      ),
    );
  }

  Widget _emailUser() {
    return Row(
      children: [
        Text(
          'Email',
          style: AppTextStyle.greyABold,
        ),
        const Spacer(),
        AppTextField(
          textEditingController: _emailController,
          hintText: 'Email',
        )
      ],
    );
  }

  Widget _groupOptions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'Settings',
            style: AppTextStyle.blackS20W800,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Column(
            children: [
              IconOtherInProfile(
                linkImg: AppImages.icLanguage,
                title: 'Language',
                isSwitch: false,
                isText: true,
              ),
              IconOtherInProfile(
                  linkImg: AppImages.icNotification,
                  title: 'Notification',
                  isSwitch: true,
                  isText: false),
              IconOtherInProfile(
                linkImg: AppImages.icDarkMode,
                title: 'Dark Mode',
                isSwitch: true,
                isText: true,
              ),
              IconOtherInProfile(
                linkImg: AppImages.icHelp,
                title: 'Help Center',
                isSwitch: false,
                isText: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonLogout() {
    return AppIconButton(
      leadingIcon: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: SvgPicture.asset(
          AppImages.icLogOut,
          width: 20,
          height: 20,
        ),
      ),
      title: 'Log Out',
      isContentCenter: true,
      backgroundColor: AppColors.black,
      onPressed: () => logOut(),
    );
  }

  void logOut() {
    _navigator.showSimpleDialog(
      title: 'Log out',
      message: 'Are you sure you want to log out?',
      onConfirm: () {
        _profileCubit.signOut();
      },
      onCancel: () => _navigator.pop(),
    );
  }
}
