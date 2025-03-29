import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/subscription_plans/subscription_plans_controller.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionPlansController());
    
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      // No AppBar - we'll add a custom header in the body
      body: Stack(
        children: [
          // Grid background (covers the entire screen now)
          const GridBackGround(),
          
          // Safe area to handle status bar
          SafeArea(
            child: Column(
              children: [
                // Custom app bar
                Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Subscription Plans',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Empty SizedBox to balance the layout
                      SizedBox(width: 48.w),
                    ],
                  ),
                ),
                
                // Tab selector for plan duration
                SizedBox(height: 16.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[800]!,
                        width: 1.h,
                      ),
                    ),
                  ),
                  child: Obx(() => Row(
                    children: [
                      _buildTabItem('1 Month', 0, controller),
                      SizedBox(width: 16.w),
                      _buildTabItem('3 Month', 1, controller),
                      SizedBox(width: 16.w),
                      _buildTabItem('6 Month', 2, controller),
                      SizedBox(width: 16.w),
                      _buildTabItem('12 Month', 3, controller),
                    ],
                  )),
                ),
                
                // Plan details
                SizedBox(height: 24.h),
                Stack(
                  children: [
                    // Shadow effect - offset to the right and bottom
                    Positioned(
                      top: 12,
                      left: 34.w,
                      right: 18.w,
                      child: Container(
                        height: 144.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    
                    // Main details container
                    Obx(() => _buildPlanDetails(controller)),
                  ],
                ),
                
                const Spacer(),
                
                // Contact us button
                Container(
                  width: double.infinity,
                  height: 52.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: ElevatedButton.icon(
                    onPressed: controller.contactUs,
                    icon: Icon(Icons.phone, color: Colors.black, size: 20.sp),
                    label: Text(
                      'Contact us',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
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
  
  Widget _buildTabItem(String text, int index, SubscriptionPlansController controller) {
    final isSelected = controller.selectedTabIndex.value == index;
    
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 2.h,
            width: text == '1 Month' ? 68.w : 60.w,
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlanDetails(SubscriptionPlansController controller) {
    final plan = controller.getSelectedPlan();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(() => Text(
                  '${controller.getSelectedPlan().price}',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )),
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Obx(() => Text(
                    controller.getSelectedPlan().duration,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  )),
                ),
              ],
            ),
          ),
          
          Divider(color: Colors.grey[800], height: 1, thickness: 1),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOW THIS SUBSCRIPTION WORKS',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(
                  'Pay ₹${controller.getSelectedPlan().price} and use service for ${controller.getSelectedPlan().daysValid} days and',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}