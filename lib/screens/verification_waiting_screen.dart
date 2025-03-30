import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/main_screen.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';
import 'package:tanq.driver.app/bindings/main_binding.dart';

class VerificationWaitingScreen extends StatelessWidget {
  const VerificationWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 0.2.sh, // 25% of screen height
            color: const Color(0xFF2E2E2E),
           
            alignment: Alignment.bottomLeft,
            child: GridBackGround()
          ),
          Transform.translate(
            offset: Offset(0, -50.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: const Color(0xFFFF6B3E),
                          size: 32.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Verification in Progress',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Mr Anandhu S Saran, Our team is currently reviewing your details. You will receive an update within 24 hours.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onTap: () {
                            Get.to(() => const MainScreen(), binding: MainBinding());
                            },
                            text: 'Contact',
                            buttonColor: Colors.white,
                            textColor: const Color(0xFF2E2E2E),
                            icon: true,
                            iconData: Icon(Icons.phone_outlined, color: const Color(0xFF2E2E2E)),
                            iconBeforeText: true,
                            border: Border.all(color: Colors.grey[300]!),
                            height: 44,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppButton(
                            onTap: () {
                             
                            },
                            text: 'Log Out',
                            buttonColor: Colors.white,
                            textColor: const Color(0xFF2E2E2E),
                            icon: true,
                            iconData: Icon(Icons.logout, color: const Color(0xFF2E2E2E)),
                            iconBeforeText: true,
                            border: Border.all(color: Colors.grey[300]!),
                            height: 44,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: 25.h,
              left: 16.w,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                Assets.images.icons.tanqDriverPng.path,
                width: 80.w,
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 