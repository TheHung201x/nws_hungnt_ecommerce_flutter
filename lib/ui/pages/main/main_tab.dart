import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MainTab {
  home,
  cart,
  notification,
  profile,
}

extension MainTabExtension on MainTab {
  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/home.svg",
            height: 20,
            width: 20,
          ),
          activeIcon:
              _isActive("Home", "assets/icon_bottom_navigation/home.svg"),
          label: "Home",
        );
      case MainTab.cart:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/cart.svg",
            height: 20,
            width: 20,
          ),
          activeIcon:
              _isActive("Cart", "assets/icon_bottom_navigation/cart.svg"),
          label: "Cart",
        );
      case MainTab.notification:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/notification.svg",
            height: 20,
            width: 20,
          ),
          activeIcon: _isActive(
              "Notifi", "assets/icon_bottom_navigation/notification.svg"),
          label: "Notifi",
        );
      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/profile.svg",
            height: 20,
            width: 20,
          ),
          activeIcon:
              _isActive("Profile", "assets/icon_bottom_navigation/profile.svg"),
          label: "Profile",
        );
    }
  }

  Widget _isActive(String title, String urlAsset) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundTabBar,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: AppColors.black, shape: BoxShape.circle),
            child: SvgPicture.asset(
              urlAsset,
              color: AppColors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              style: AppTextStyle.blackS14Bold,
            ),
          )
        ],
      ),
    );
  }
}
