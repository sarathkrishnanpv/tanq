import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetUtils {
  static Future<String?> showRejectionReasonSheet() {
    final selectedReason = ''.obs;
    
    final reasons = [
      {
        'title': 'Long Pickup Distance',
        'description': 'The pickup location is too far from the driver\'s current location.',
      },
      {
        'title': 'Low Fare',
        'description': 'The estimated fare for the ride is too low, making it not worth the trip.',
      },
      {
        'title': 'Traffic Conditions',
        'description': 'Heavy traffic in the pickup or drop-off area might make the trip time-consuming.',
      },
      {
        'title': 'Destination Issue',
        'description': 'The user has a history of frequently canceling rides.',
      },
      {
        'title': 'High Cancellation Rate',
        'description': 'The pickup location is too far from the driver\'s current location.',
      },
    ];

    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gray line at top
            Container(
              width: 48.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            // Title with exact styling
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Reason for rejecting this ride',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Divider(height: 1, color: Colors.grey[200]),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: reasons.map((reason) => Obx(() => 
                    InkWell(
                      onTap: () => selectedReason.value = reason['title']!,
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedReason.value == reason['title'] 
                                ? Colors.blue 
                                : Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          children: [
                          
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reason['title']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    reason['description']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedReason.value.isNotEmpty) {
                      Get.back(result: selectedReason.value);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Submit Reason',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
} 