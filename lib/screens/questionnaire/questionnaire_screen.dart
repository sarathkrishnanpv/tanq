import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';

class QuestionnaireScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final int currentStep;
  final int totalSteps;
  final Widget child;
  final VoidCallback onContinue;
  final VoidCallback? onBack;

  const QuestionnaireScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.currentStep,
    required this.totalSteps,
    required this.child,
    required this.onContinue,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const GridBackGround(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and progress
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      if (onBack != null)
                        IconButton(
                          onPressed: onBack,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '$currentStep/$totalSteps',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title and subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Main content area
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.r),
                        topRight: Radius.circular(2.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(20.w),
                            physics: const BouncingScrollPhysics(),
                            child: child,
                          ),
                        ),
                        // Continue button
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
} 