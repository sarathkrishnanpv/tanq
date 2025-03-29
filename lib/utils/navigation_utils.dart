import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/main_controller.dart';

class NavigationUtils {
  // Private constructor to prevent instantiation
  NavigationUtils._();
  
  // Settings related navigation
  static void toPersonalInformation() {
    Get.toNamed('/personal-information');
  }
  
  static void toLanguageSelection() {
    Get.toNamed('/change-language');
  }
  
  static void toProfile() {
    Get.toNamed('/profile');
  }
  
  static void toSubscriptions() {
    Get.toNamed('/subscriptions');
  }
  
  static void toRideHistory() {
    Get.toNamed('/ride-history');
  }
  
  // Ride related navigation
  static void toNewRideDetails() {
    Get.toNamed('/ride-details');
  }
  
  static void toAcceptedRide() {
    Get.offNamed('/accepted-ride');
  }
  
  // Common navigation actions
  static void back<T>({T? result}) {
    Get.back(result: result);
  }
  
  static void until(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }
  
  static void offAllToHome() {
    Get.offAllNamed('/home');
  }
  
  // Bottom navigation
  static void switchTab(int index) {
    Get.find<MainController>().changeTab(index);
  }
  
  // Modal bottom sheets
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    return Get.bottomSheet(
      child,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
    );
  }
  
  // Dialog helpers
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return Get.dialog(
      child,
      barrierDismissible: barrierDismissible,
    );
  }
  
  // Snackbar helpers
  static void showSuccessSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
  
  static void showErrorSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
  
  // Loading dialog
  static void showLoading({String? message}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static Future<T?> pushWithSlideTransition<T>(
      BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static Future<T?> pushReplacementWithSlideTransition<T, TO>(
      BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, TO>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static Future<T?> pushWithFadeTransition<T>(
      BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var fadeTween = Tween(begin: 0.0, end: 1.0);
          var curveTween = CurveTween(curve: Curves.fastLinearToSlowEaseIn);

          return FadeTransition(
            opacity: animation.drive(fadeTween.chain(curveTween)),
            child: child,
          );
        },
      ),
    );
  }

  static Future<T?> pushReplacementWithFadeTransition<T, TO>(
      BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, TO>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var fadeTween = Tween(begin: 0.0, end: 1.0);
          var curveTween = CurveTween(curve: Curves.easeInOut);

          return FadeTransition(
            opacity: animation.drive(fadeTween.chain(curveTween)),
            child: child,
          );
        },
      ),
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }
} 