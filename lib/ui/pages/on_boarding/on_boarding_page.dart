import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_cubit.dart';
import 'package:ecommerce/ui/pages/on_boarding/widgets/item_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnBoardingCubit();
      },
      child: const OnBoardingChildPage(),
    );
  }
}

class OnBoardingChildPage extends StatefulWidget {
  const OnBoardingChildPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingChildPage> createState() => _OnBoardingChildPageState();
}

class _OnBoardingChildPageState extends State<OnBoardingChildPage> {
  late OnBoardingCubit _boardingCubit;
  final controller = PageController();

  List<Map<String, dynamic>> onboardingList = [
    {
      'title': S.current.onboarding_title_01,
      'image': AppImages.onBoarding1
    },
    {
      'title': S.current.onboarding_title_02,
      'image': AppImages.onBoarding2
    },
    {
      'title': S.current.onboarding_title_03,
      'image': AppImages.onBoarding3
    },
  ];

  @override
  void initState() {
    _boardingCubit = BlocProvider.of<OnBoardingCubit>(context);
    _boardingCubit.setFlag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _sliderImageOnboarding(),
            _indicatorAndButtonSkip(),
          ],
        ),
      ),
    );
  }

  Widget _sliderImageOnboarding() {
    return Expanded(
      child: PageView.builder(
        itemCount: onboardingList.length,
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ItemOnboarding(
              pathImage: onboardingList[position]['image'],
              title: onboardingList[position]['title'],
            ),
          );
        },
      ),
    );
  }

  Widget _indicatorAndButtonSkip() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            axisDirection: Axis.horizontal,
            controller: controller,
            count: onboardingList.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColors.black,
              dotColor: AppColors.imageBG,
              dotHeight: 8,
              dotWidth: 10,
              spacing: 4,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (controller.page == 2) {
                context.go('/auth');
              }
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: SvgPicture.asset(
              AppImages.icNext,
              height: 50,
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}
