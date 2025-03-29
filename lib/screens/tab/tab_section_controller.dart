// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tanq_rider/screens/tab_sections/account/account_screen.dart';
// import 'package:tanq_rider/screens/tab_sections/activity/activity_screen.dart';
// import 'package:tanq_rider/screens/tab_sections/home/home_screen.dart';
// import 'package:tanq_rider/screens/tab_sections/services/services.dart';

// class TabSectionController extends GetxController {
//   DateTime? lastPressed;
//   RxInt currentIndex = 0.obs;
//   final List<Widget> pages = [
//     const HomeScreen(),
//     ServicesScreen(),
//     const ActivityScreen(),
//     AccountScreen(),
//   ];
//   void bottomIndex(int index) {
//     currentIndex.value = index;
//   }

//   Future<bool> onWillPop() async {
//     final now = DateTime.now();

//     if (lastPressed == null ||
//         now.difference(lastPressed!) > const Duration(seconds: 2)) {
//       lastPressed = now;

//       Get.snackbar(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         'Exit App',
//         'Press back again to exit',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 2),
//         backgroundColor: Colors.black45,
//         colorText: Colors.white,
//       );

//       return false;
//     }
//     return true;
//   }
// }
