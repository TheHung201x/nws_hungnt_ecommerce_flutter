import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/pages/on_boarding/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int flag = 1;
  late OnBoardingCubit _boardingCubit;
  final controller = PageController();

  @override
  void initState() {
    _boardingCubit = BlocProvider.of<OnBoardingCubit>(context);
    _boardingCubit.setFlag(flag);
    super.initState();
  }

  List<Map<String, dynamic>> image = [
    {
      'title': '20% Discount \nNew Arrival Product',
      'image': AppImages.onBoarding1
    },
    {
      'title': 'Take Advantage \nOf The Ofter Shopping',
      'image': AppImages.onBoarding2
    },
    {
      'title': 'All Types Offers \nWithin Your Reach',
      'image': AppImages.onBoarding3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: image.length,
                scrollDirection: Axis.horizontal,
                controller: controller,
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _onBoarding(
                      context,
                      image[position]['image'],
                      image[position]['title'],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    axisDirection: Axis.horizontal,
                    controller: controller,
                    count: image.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.textBlack,
                      dotColor: AppColors.imageBG,
                      dotHeight: 8,
                      dotWidth: 10,
                      spacing: 4,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      if (controller.page == 2) {
                        context.go('/auth');
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/vectors/next.svg",
                      height: 50,
                      width: 50,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onBoarding(BuildContext context, String pathImage, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            transform: Matrix4.skewY(-0.07),
            height: MediaQuery.of(context).size.height / 2 + 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  pathImage,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: AppTextStyle.blackS30Bold,
            ),
          ),
          subtitle: const Text(
            "Publish up your selfies to make yourself \nmore beautiful with this app",
            style: AppTextStyle.grey,
          ),
        )
      ],
    );
  }
}
