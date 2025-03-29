// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:tanq.driver.app/gen/assets.gen.dart';
// import 'package:tanq.driver.app/screens/tab/tab_section_controller.dart';
// import 'package:tanq.driver.app/themes/app_colors.dart';
// import 'package:tanq.driver.app/utils/global.dart';
// imp

// class TabSection extends GetView<TabSectionController> {
//   const TabSection({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(TabSectionController());
//     return Obx(() {
//       return PopScope(
//         canPop: false,
//         onPopInvokedWithResult: (didPop, s) async {
//           if (didPop) {
//             return;
//           }
//           final shouldPop = await controller.onWillPop();
//           if (shouldPop) {
//             SystemNavigator.pop();
//           }
//         },
//         child: Scaffold(
//           backgroundColor: AppColors.backgroundColor,
//           body: controller.pages[controller.currentIndex.value],
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               color: AppColors.backgroundColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 2,
//                   offset: const Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 3,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(4, (index) {
//                       return Expanded(
//                         child: AnimatedContainer(
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           alignment: Alignment.center,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInCirc,
//                           height: 3,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: index == controller.currentIndex.value
//                                 ? AppColors.primary
//                                 : AppColors.transparent,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 BottomNavigationBar(
//                   enableFeedback: false,
//                   elevation: 0,
//                   backgroundColor: AppColors.backgroundColor,
//                   type: BottomNavigationBarType.fixed,
//                   selectedItemColor: AppColors.primary,
//                   selectedLabelStyle: const TextStyle(
//                       color: AppColors.primary,
//                       fontSize: 12,
//                       fontFamily: "Commissioner"),
//                   unselectedLabelStyle: const TextStyle(
//                       color: AppColors.black,
//                       fontSize: 11,
//                       fontFamily: "Commissioner"),
//                   unselectedItemColor: AppColors.black,
//                   items: <BottomNavigationBarItem>[
//                     BottomNavigationBarItem(
//                       icon: _iconsImg(img: Assets.images.icons.home),
//                       activeIcon: _iconsImg(img: Assets.images.icons.homeActive),
//                       label: "Home",
//                     ),
//                     BottomNavigationBarItem(
//                       icon: _iconsImg(img: Assets.images.icons.services),
//                       activeIcon: _iconsImg(img: Assets.images.icons.serviceActive),
//                       label: "Services",
//                     ),
//                     BottomNavigationBarItem(
//                       icon: _iconsImg(img: Assets.images.icons.activity),
//                       activeIcon: _iconsImg(img: Assets.images.icons.activityActive),
//                       label: "Activity",
//                     ),
//                     BottomNavigationBarItem(
//                       icon: _iconsImg(img: Assets.images.icons.account),
//                       activeIcon: _iconsImg(img: Assets.images.icons.accountActive),
//                       label: "Account",
//                     ),
//                   ],
//                   currentIndex: controller.currentIndex.value,
//                   onTap: (value) async {
//                     controller.bottomIndex(value);
//                   },
//                   selectedFontSize: 12,
//                   unselectedFontSize: 12,
//                   showUnselectedLabels: true,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// Widget _iconsImg({required String img}) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 5),
//     child: SvgPicture.asset(
//       img,
//       width: Constants.width * 0.1,
//       height: Constants.height * 0.025,
//     ),
//   );
// }
