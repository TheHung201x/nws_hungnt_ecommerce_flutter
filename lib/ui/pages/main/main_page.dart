import 'package:ecommerce/blocs/setting/app_setting_cubit.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/ui/pages/main/main_cubit.dart';
import 'package:ecommerce/ui/pages/main/main_navigator.dart';
import 'package:ecommerce/ui/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit(
        navigator: MainNavigator(context: context),
      ),
      child: _MainPage(child: child),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  late List<Widget> pageList;
  late MainCubit _mainCubit;
  DateTime? _lastPressedAt;

  var currentIndex = 0;

  final locale = const Locale.fromSubtags(languageCode: 'vi');

  List<String> nameListOfTab = [
    S.current.home,
    S.current.cart,
    S.current.notifi,
    S.current.profile,
  ];

  List<String> iconsListOfTab = [
    "assets/icon_bottom_navigation/home.svg",
    "assets/icon_bottom_navigation/cart.svg",
    "assets/icon_bottom_navigation/notification.svg",
    "assets/icon_bottom_navigation/profile.svg",
  ];

  @override
  void initState() {
    _mainCubit = BlocProvider.of<MainCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillScope(),
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    double displayWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (previous, current) {
        return previous.locale != current.locale;
      },
      builder: (context, state) {
        // Set lại state khi thay đổi ngôn ngữ bottom nav
        nameListOfTab = [
          S.current.home,
          S.current.cart,
          S.current.notifi,
          S.current.profile,
        ];
        return Container(
          height: displayWidth * .165,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Center(
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  currentIndex = index;
                  _mainCubit.switchTap(index);
                  HapticFeedback.lightImpact();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn,
                      // Nếu ngôn ngữ là tiếng việt thì kéo dài width của background tab
                      width: index == currentIndex
                          ? (state.locale == locale
                              ? displayWidth * .40
                              : displayWidth * .32)
                          : displayWidth * .18,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .12 : 0,
                        width: index == currentIndex ? displayWidth * .32 : 0,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: index == currentIndex
                              ? Colors.grey.withOpacity(.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .15
                                    : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == currentIndex
                                      ? nameListOfTab[index]
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .03
                                    : 20,
                              ),
                              index == currentIndex
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        iconsListOfTab[index],
                                        height: 18,
                                        width: 18,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.white, BlendMode.srcIn),
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      iconsListOfTab[index],
                                      height: 20,
                                      width: 20,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onWillScope() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) >
            const Duration(seconds: 2)) {
      _lastPressedAt = DateTime.now();
      showSnackBar(context, S.current.notification_close_app);
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
