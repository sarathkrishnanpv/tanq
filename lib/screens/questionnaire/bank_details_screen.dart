import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/widgets/custom_app_bar.dart';

import 'questionnaire_controller.dart';

class BankDetailsScreen extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Bank Details',
        showBackButton: true,
        progressText: '6/7',
        progressValue: 0.857,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              duration: const Duration(milliseconds: 200),
              child: Text(
                'Enter your bank details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            FadeIn(
              duration: const Duration(milliseconds: 200),
              child: Text(
                'Please provide your bank account information for payments',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Bank Details Form - Coming Soon
            FadeIn(
              duration: const Duration(milliseconds: 200),
              child: Center(
                child: Text(
                  'Bank Details Form - Coming Soon',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 