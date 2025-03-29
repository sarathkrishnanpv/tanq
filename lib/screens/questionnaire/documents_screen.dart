import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({Key? key}) : super(key: key);

  final controller = Get.find<QuestionnaireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
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
                        SizedBox(width: 4.w),
                        IconButton(
                          onPressed: () {
                            controller.previousStep();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(width: 8.w),
                        Row(
                          children: [
                            Text(
                              'Documents',
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
                                color: const Color(0xFF2196F3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '4/5',
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
                          width: MediaQuery.of(context).size.width * (3 / 5),
                          color: const Color(0xFF2196F3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Documents Screen',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} 