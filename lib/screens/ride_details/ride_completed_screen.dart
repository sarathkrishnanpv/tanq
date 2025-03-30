import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/main_screen.dart';

class RideCompletedScreen extends StatelessWidget {
  final double earnings;
  
  const RideCompletedScreen({
    Key? key,
    required this.earnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),
              // Logo
              Text(
                'tanQ',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32.h),
              
              // Auto rickshaw image
              Image.asset(
                Assets.images.normal.suv.path,
                width: 140.w,
                height: 140.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),
              
              // Success message
              Text(
                'Ride Successfully',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E7D32), // Material Green 800
                ),
              ),
              Text(
                'Completed.',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E7D32), // Material Green 800
                ),
              ),
              SizedBox(height: 32.h),
              
              // Earnings amount
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    '${earnings.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Subtitle
              Text(
                'You have earned',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              
              // End Ride button
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 32.h),
                child: ElevatedButton(
                  onPressed: () {
                Navigator.pop(context);
        
            
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'End Ride',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 