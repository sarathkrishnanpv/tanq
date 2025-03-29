import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'home_screen/home_screen.dart';
import 'earnings_screen/earnings_screen.dart';
import 'notifications_screen/notifications_screen.dart';
import 'settings_screen/settings_screen.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    
    final List<Widget> screens = [
      const HomeScreen(),
      const EarningsScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
    
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog when trying to exit app with back button
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Exit App',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                'Are you sure you want to exit?',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              backgroundColor: Colors.white,
            );
          },
        );

        return shouldPop ?? false;
      },
      child: Obx(() => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: screens,
        ),
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                HapticFeedback.lightImpact();
                controller.changeTab(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              iconSize: 20.h,
              selectedFontSize: 10.sp,
              unselectedFontSize: 10.sp,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 20.h,
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 0 
                          ? Assets.images.icons.homeDark 
                          : Assets.images.icons.homeLight,
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 0 ? Colors.black : Colors.grey, 
                        BlendMode.srcIn
                      ),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 20.h,
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 1 
                          ? Assets.images.icons.earningsDark 
                          : Assets.images.icons.earningsLight,
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 1 ? Colors.black : Colors.grey, 
                        BlendMode.srcIn
                      ),
                    ),
                  ),
                  label: 'Earnings',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 20.h,
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 2 
                          ? Assets.images.icons.notificationDark 
                          : Assets.images.icons.notificationLight,
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 2 ? Colors.black : Colors.grey, 
                        BlendMode.srcIn
                      ),
                    ),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 20.h,
                    child: Transform.scale(
                      scale:1,
                      child: SvgPicture.asset(   
                        controller.selectedIndex.value == 3 
                            ? Assets.images.icons.settingsSvg 
                            : Assets.images.icons.settingsSvg,
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 3 ? Colors.black : Colors.grey, 
                        BlendMode.srcIn
                      ),
                      ),
                    ),
                  ),
                  label: 'Settings',
                ),
              ],
            ),
            // Notification badge positioned above the navbar
            if (controller.unreadNotificationsCount.value > 0)
              Positioned(
                top: 7.h,
                right: MediaQuery.of(context).size.width * 0.29, // Position above notifications icon
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration( 
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14.w,
                    minHeight: 14.h,
                  ),
                  child: Text(
                    controller.unreadNotificationsCount.value > 99 
                        ? '99+' 
                        : '99+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      )));
  }
} 