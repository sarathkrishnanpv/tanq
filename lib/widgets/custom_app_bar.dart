import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final String progressText;
  final double progressValue;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    required this.progressText,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.h),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 56.h,
                  child: Row(
                    children: [
                      if (showBackButton) ...[
                        SizedBox(width: 4.w),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1c67f2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              progressText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2.h,
                  color: Colors.grey[200],
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * progressValue,
                        color: const Color(0xFF1c67f2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
} 