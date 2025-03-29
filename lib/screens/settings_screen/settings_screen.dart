import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/ride_history/ride_history_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/screens/tanq_shop/shop_screen/shop_home.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';
import 'profile_screen.dart';
import 'package:tanq.driver.app/screens/subscription_plans/subscription_plans_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradient
          const GridBackGround(),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main content (white background)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Shortcuts Section
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 16.h),
                            child: Text(
                              'Shortcuts',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          _buildShortcutsRow(),
                          
                          SizedBox(height: 24.h),
                          
                          // Account Settings Section
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
                            child: Text(
                              'Account Settings',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.settings,
                            title: 'M-PIN',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.email,
                            title: 'Manage subscriptions & payments',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItemWithSwitch(
                            iconPath: Assets.images.icons.pushNotification,
                            title: 'Push notifications',
                            initialValue: true,
                            onChanged: (value) {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.email,
                            title: 'Email & SMS preferences',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItemWithSubtitle(
                            iconPath: Assets.images.icons.language,
                            title: 'Languages',
                            subtitle: 'മലയാളം Selected',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.terms,
                            title: 'Terms and condition',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.help,
                            title: 'Help and support',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          
                          // Additional Options
                          _buildSettingsItemWithSubtitle(
                            iconPath: Assets.images.icons.rateUs,
                            title: 'Rate us',
                            subtitle: 'Playstore or app store',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.share,
                            title: 'Share tanQ',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildSettingsItem(
                            iconPath: Assets.images.icons.delete,
                            title: 'Delete account',
                            onTap: () {},
                          ),
                          const Divider(height: 1, thickness: 1),
                          _buildLogoutItem(),
                          const Divider(height: 1, thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildShortcutItem(
          imagePath: Assets.images.normal.firstPng.path,
          title: 'Subscriptions',
          onTap: () {Get.to(() => const SubscriptionPlansScreen());},
        ),
        _buildShortcutItem(
          imagePath: Assets.images.normal.second.path,
          title: 'Tanq Store',
          onTap: () {Get.to(() => const ShopHome());},
        ),
        _buildShortcutItem(
          imagePath:Assets.images.normal.third.path,
          title: 'Ride History',
          onTap: () {Get.to(() => const RideHistoryScreen());},
        ),
      ],
    );
  }

  Widget _buildShortcutItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  delay: const Duration(milliseconds: 200),
                  child: Image.asset(
                    imagePath,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  
                
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.r,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItemWithSubtitle({
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
               
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.r,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItemWithSwitch({
    required String iconPath,
    required String title,
    required bool initialValue,
    required ValueChanged<bool> onChanged,
  }) {
    // Using Rx for toggle state
    final isToggled = initialValue.obs;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
               
                
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Obx(() => Switch(
            value: isToggled.value,
            onChanged: (value) {
              isToggled.value = value;
              onChanged(value);
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
          )),
        ],
      ),
    );
  }

  Widget _buildLogoutItem() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.1),
              ),
              child: Center(
                  child: SvgPicture.asset(
                    Assets.images.icons.logout,
                
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                'logout',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 