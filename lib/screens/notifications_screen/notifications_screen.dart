import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'package:tanq.driver.app/widgets/grid_background.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(NotificationsController());
    
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          const GridBackGround(),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                     
                    ],
                  ),
                ),
                
                // Notification List - White container with rounded corners
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: Obx(() {
                      if (controller.notifications.isEmpty) {
                        return _buildEmptyState();
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.only(top: 12.h),
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemCount: controller.notifications.length,
                          itemBuilder: (context, index) {
                            final notification = controller.notifications[index];
                            return _buildNotificationItem(notification);
                          },
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 72,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You\'ll be notified about new rides and transactions',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final dateFormat = DateFormat('dd MMM yyyy, h:mm a');
    final formattedDate = dateFormat.format(notification['date'] as DateTime);
    
    // Icon based on notification type
    String icon;
    Color iconBgColor;
    
    if (notification['type'] == 'transaction') {
      icon = Assets.images.icons.carNotificationIcon;
      iconBgColor = Colors.blue;
    } else if (notification['type'] == 'ride_request') {
      icon = Assets.images.icons.newRideNotification;
      iconBgColor = Colors.blue;
    } else {
      icon = Assets.images.icons.carNotificationIcon;
      iconBgColor = Colors.grey;
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: SvgPicture.asset(icon),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Twow(),
                      if (notification['isNew'] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.darkRed,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 1000.ms, color: Colors.white.withOpacity(0.7)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
            child: Text(
              notification['title'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Text(
            notification['message'] as String,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

