import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/models/enums/load_status.dart';
import 'package:ecommerce/ui/pages/profile/profile_cubit.dart';
import 'package:ecommerce/ui/pages/profile/profile_navigator.dart';
import 'package:ecommerce/ui/pages/profile/profile_state.dart';
import 'package:ecommerce/ui/pages/profile/widgets/icon_other.dart';
import 'package:ecommerce/ui/widget/app_circular_progress_indicator.dart';
import 'package:ecommerce/ui/widget/buttons/app_icon_button.dart';
import 'package:ecommerce/ui/widget/list/error_list_widget.dart';
import 'package:ecommerce/ui/widget/shimmer/app_shimmer.dart';
import 'package:ecommerce/ui/widget/textfields/app_text_field.dart';
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
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    height: 100,
                                    width: 100,
                                    imageUrl: state.user?.avatar ?? '',
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.network(AppImages.imageDefault),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: -8,
                                  right: -8,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: SvgPicture.asset(AppImages.pen),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Upload Image',
                                style: AppTextStyle.blackS16W600)
                          ],
                        ),
                      ),
                      Padding(
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
                      ),
                      Row(
                        children: [
                          Text(
                            'Gender',
                            style: AppTextStyle.greyABold,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 220,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 14,
                                        height: 14,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(

                                          color: AppColors.white,
                                          )
                                        ),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Male',
                                        style: AppTextStyle.whiteS12Bold,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    border: Border.all(color: AppColors.greyD),
                                  ),
                                  height: 40,
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(
                                              color: AppColors.greyD,
                                            )
                                        ),
                                      ),
                                      Text(
                                        'Female',
                                        style: AppTextStyle.greyA12Blod,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
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
                      ),
                      Row(
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
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Settings',
                        style: AppTextStyle.blackS20W800,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 24),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            IconOtherInProfile(
                              linkImg: AppImages.language,
                              title: 'Language',
                              isSwitch: false,
                              isText: true,
                            ),
                            IconOtherInProfile(
                                linkImg: AppImages.notification,
                                title: 'Notification',
                                isSwitch: true,
                                isText: false),
                            IconOtherInProfile(
                              linkImg: AppImages.darkMode,
                              title: 'Dark Mode',
                              isSwitch: true,
                              isText: true,
                            ),
                            IconOtherInProfile(
                              linkImg: AppImages.help,
                              title: 'Help Center',
                              isSwitch: false,
                              isText: false,
                            ),
                          ],
                        ),
                      ),
                      AppIconButton(
                        leadingIcon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(
                            AppImages.logOut,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        title: 'Log Out',
                        isContentCenter: true,
                        backgroundColor: AppColors.black,
                        onPressed: () {
                          _navigator.showSimpleDialog(
                              title: 'Are you sure you want to log out?',
                              onConfirm: () {
                                _profileCubit.signOut();
                                print("state ${state.signOutStatus}");
                              },
                              onCancel: () => _navigator.pop());
                        },
                      ),
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
}
