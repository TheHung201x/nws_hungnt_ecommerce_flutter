import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/pages/cart/cart_page.dart';
import 'package:ecommerce/ui/pages/home/home_page.dart';
import 'package:ecommerce/ui/pages/notification/notification_page.dart';
import 'package:ecommerce/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MainTab {
  home,
  cart,
  notification,
  profile,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
        return const HomePage();
      case MainTab.cart:
        return const CartPage();
      case MainTab.notification:
        return const NotificationPage();
      case MainTab.profile:
        return const ProfilePage();
    }
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/home.svg",
            height: 20,
            width: 20,
          ),
          activeIcon: _isActive("Home","assets/icon_bottom_navigation/home.svg"),
          label: "Home",
        );
      case MainTab.cart:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/cart.svg",
            height: 20,
            width: 20,
          ),
          activeIcon: _isActive("Cart","assets/icon_bottom_navigation/cart.svg"),
          label: "Cart",
        );
      case MainTab.notification:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/notification.svg",
            height: 20,
            width: 20,
          ),
          activeIcon: _isActive("Notification","assets/icon_bottom_navigation/notification.svg"),
          label: "Notification",
        );
      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icon_bottom_navigation/profile.svg",
            height: 20,
            width: 20,
          ),
          activeIcon: _isActive("Profile","assets/icon_bottom_navigation/profile.svg"),
          label: "Profile",
        );
    }
  }

  Widget _isActive(String title, String urlAsset) {
    return Container(
      decoration: BoxDecoration(
      color: AppColors.backgroundTabBar,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: AppColors.textBlack, shape: BoxShape.circle),
            child: SvgPicture.asset(
              urlAsset,
              height: 16,
              width: 16,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(width: 6,),
          Expanded(child: Text(title, style: AppTextStyle.blackS14Bold,))
        ],
      ),
    );
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.cart:
        return 'Cart';
      case MainTab.notification:
        return 'Notification';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
