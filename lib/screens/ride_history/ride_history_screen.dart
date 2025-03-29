import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'ride_history_controller.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RideHistoryController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Ride History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Handle calendar action
              controller.clearDateFilter();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(Assets.images.icons.calendarDark),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        ),
        child: Obx(() {
          if (controller.rideHistory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'No rides found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (controller.selectedDate.value != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        'for ${DateFormat('dd MMM yyyy').format(controller.selectedDate.value!)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: controller.rideHistory.length,
            itemBuilder: (context, index) {
              final ride = controller.rideHistory[index];
              return _buildRideHistoryItem(ride);
            },
          );
        }),
      ),
    );
  }

  Widget _buildRideHistoryItem(Map<String, dynamic> ride) {
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 2,
      locale: 'en_IN',
    );
    
    final dateFormat = DateFormat('hh:mm a, dd MMM yyyy');
    final formattedDate = dateFormat.format(ride['date'] as DateTime);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.images.icons.suvPng.path,
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      'ID: ${ride['id']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4.w),
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 12,
                            color:AppColors.darkGreen
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                   Row(
                    
                      children: [
                        Text(
                          'More Details',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  
                 
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_downward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride['pickupLocation'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pickup location',
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
                Row(
                  children: [
                    SizedBox(width: 16.w),
                    SizedBox(
                      height: 40.h,
                      width: 2,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Container(
                              height: 2,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: AppColors.darkBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride['dropoffLocation'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Drop-off location',
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
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Date and Time:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ride Payment :',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    currencyFormat.format(ride['fare']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0Xff008000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 