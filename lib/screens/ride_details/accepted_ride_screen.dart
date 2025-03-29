import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:tanq.driver.app/widgets/custom_slider_button.dart';
import 'ride_completed_screen.dart';
import 'package:tanq.driver.app/utils/animated_dotted_line.dart';
import 'package:tanq.driver.app/widgets/map_example_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;
import 'package:tanq.driver.app/widgets/otp_verification_sheet.dart';

class AcceptedRideController extends GetxController {
  final RxBool isArrivedAtPickup = false.obs;
  final RxBool isDetailExpanded = false.obs;
  final RxInt estimatedMinutes = 12.obs;
  final RxString pickupLocation = 'Koramangla'.obs;
  final RxString dropLocation = 'Museum Junction'.obs;
  
  // Ride flow states
  final RxBool isRideStarted = false.obs;
  final RxBool isOtpVerified = false.obs;
  final RxBool isRideCompleted = false.obs;
  
  // Passenger info
  final RxString passengerName = 'Anandhu'.obs; // This would come from API in real app
  
  // Timer to simulate decreasing ETA
  Timer? _timer;
  
  @override
  void onInit() {
    super.onInit();
    // Start a timer to simulate decreasing ETA
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (estimatedMinutes.value > 1) {
        estimatedMinutes.value--;
      } else {
        timer.cancel();
      }
    });
  }
  
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  
  void toggleDetails() {
    isDetailExpanded.value = !isDetailExpanded.value;
  }
  
  void markArrivedAtPickup() {
    isArrivedAtPickup.value = true;
  }
  
  void startRide() {
    // Show OTP verification sheet
    Get.bottomSheet(
      OtpVerificationSheet(
        riderName: passengerName.value,
        onVerified: () {
          Get.back(); // Close the sheet
          _completeOtpVerification();
        },
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
    );
  }
  
  void _completeOtpVerification() {
    isOtpVerified.value = true;
    isRideStarted.value = true;
  }
  
  void completeRide() {
    isRideCompleted.value = true;
    // Navigate to RideCompletedScreen with earnings
    Get.off(() => const RideCompletedScreen(earnings: 68.00), transition: Transition.rightToLeft);
  }
  
  void callPassenger() {
    // Implement passenger call functionality
  }
  
  void openOptions() {
    // Implement options menu
  }
  
  void contactSupport() {
    // Implement support contact
  }
  
  void reportIssue() {
    // Implement report issue
  }
  
  void cancelRide() {
    // Implement ride cancellation
    Get.back();
  }
}

class AcceptedRideScreen extends StatelessWidget {
  const AcceptedRideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AcceptedRideController());
    
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          // Full screen map with enhanced elements
          SizedBox.expand(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(8.5241, 76.9366),
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                // Route polyline
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        LatLng(8.5241, 76.9366), // Starting point
                        LatLng(8.5270, 76.9400), // Via point 1
                        LatLng(8.5300, 76.9450), // Via point 2
                        LatLng(8.5320, 76.9480), // Destination
                      ],
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
                // Markers layer
                MarkerLayer(
                  markers: [
                    // Driver marker (car)
                    Marker(
                      width: 60.w,
                      height: 60.h,
                      point: LatLng(8.5241, 76.9366),
                      child: Transform.rotate(
                        angle: 0.5, // Simulate car direction
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    // Pickup marker
                    Marker(
                      width: 80.w,
                      height: 80.h,
                      point: LatLng(8.5300, 76.9450),
                      child: Column(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              controller.pickupLocation.value,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Destination marker
                    Marker(
                      width: 80.w,
                      height: 80.h,
                      point: LatLng(8.5320, 76.9480),
                      child: Column(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.flag,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              controller.dropLocation.value,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
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
          
          // Top navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                          onTap: () => Get.back(),
                          child:Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: SvgPicture.asset(Assets.images.icons.arrowBack,height: 24.h,width: 24.w,),
                            )
                         ),
                      
                          Text('Ride with Ananthu',style: TextStyle(fontSize:17,fontWeight: FontWeight.w500,color: Colors.black),),
                       Icon(Icons.more_vert,color: Colors.black,size: 24.sp,)
                       ],
                     ),
                   ),
                    
                  Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Back button
                      
                        // Arrival time information
                        controller.isArrivedAtPickup.value
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    'Waiting for passenger',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Minutes indicator
                                    Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Obx(() => Text(
                                            '${controller.estimatedMinutes.value}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Text(
                                            'Min',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    // Arrival info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Est reaching time 12:45 PM to',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Obx(() => Text(
                                            '${controller.pickupLocation.value} to pick up',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        
                        // Map view button
                        // Padding(
                        //   padding: EdgeInsets.only(right: 8.w),
                        //   child: MapExampleButton(
                        //     rideId: '123', // Pass actual ride ID when available
                        //     pickup: controller.pickupLocation.value,
                        //     destination: controller.dropLocation.value,
                        //     buttonColor: Colors.blue[700],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom details sheet with fixed action button
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                // We can add logic here if needed when sheet is dragged
                return true;
              },
              child: Stack(
                children: [
                  DraggableScrollableSheet(
                    initialChildSize: 0.25,
                    minChildSize: 0.25,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Handle for dragging
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            
                            // Content area (scrollable)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 80.h),  // Add padding for button
                                child: ListView(
                                  controller: scrollController,
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  children: [
                                    // Passenger info card
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Passenger avatar
                                          CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: Colors.grey[200],
                                            backgroundImage: const AssetImage('assets/images/normal/user.png'),
                                          ),
                                          SizedBox(width: 12.w),
                                          // Passenger name
                                          Expanded(
                                            child: Text(
                                              'Ramesh Jain',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Call button
                                          SizedBox(
                                            width: 48.w,
                                            height: 48.h,
                                            child: IconButton(
                                              icon: Icon(Icons.phone, size: 24),
                                              onPressed: controller.callPassenger,
                                            ),
                                          ),
                                          // Options button
                                          SizedBox(
                                            width: 48.w,
                                            height: 48.h,
                                            child: IconButton(
                                              icon: Icon(Icons.more_vert, size: 24),
                                              onPressed: controller.openOptions,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Distance & Payment
                                    Text(
                                      'Distance & Payment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16.r),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Fare
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '₹ ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '68.00',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'Pay for Ride',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          // Distance
                                          Text(
                                            '12.4 KM',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'Total distance to destination',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Ride Details
                                    SizedBox(height: 16.h),
                                    Text(
                                      'Ride Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16.r),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Column(
                                        children: [
                                          // Pickup location
                                          _buildDetailRow('Pickup location:', 'Museum Junction'),
                                          SizedBox(height: 12.h),
                                          // Ride ID
                                          _buildDetailRow('Ride ID:', 'FGA32425'),
                                          SizedBox(height: 12.h),
                                          // Date and Time
                                          _buildDetailRow('Date and Time:', '12:47 PM, 12 Nov 2024'),
                                        ],
                                      ),
                                    ),
                                    
                                    // Actions
                                    SizedBox(height: 16.h),
                                    Text(
                                      'Actions',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    
                                    // Contact Support
                                    _buildActionButton(
                                      icon: Icons.headset_mic,
                                      text: 'Contact Support',
                                      onTap: controller.contactSupport,
                                    ),
                                    
                                    // Report
                                    _buildActionButton(
                                      icon: Icons.report_problem,
                                      text: 'Report',
                                      onTap: controller.reportIssue,
                                    ),
                                    
                                    // Cancel Ride
                                    _buildActionButton(
                                      icon: Icons.cancel,
                                      text: 'Cancel Ride',
                                      textColor: Colors.red,
                                      onTap: controller.cancelRide,
                                    ),
                                    
                                    // Extra bottom padding
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // Fixed action button at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.r),
                      child: Obx(() {
                        if (controller.isRideStarted.value && !controller.isRideCompleted.value) {
                          // Show slider button to complete ride after OTP verification
                          return CustomSlideButton(
                            onSlideComplete: () => controller.completeRide(),
                            text: 'Complete ride',
                          );
                        } else if (controller.isArrivedAtPickup.value && !controller.isRideStarted.value) {
                          // Show "Start Ride" button to trigger OTP verification
                          return ElevatedButton(
                            onPressed: controller.startRide,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow, color: Colors.white, size: 20),
                                SizedBox(width: 8.w),
                                Text(
                                  'Start Ride',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Show arrival button
                          return CustomSlideButton(
                            onSlideComplete: () => controller.markArrivedAtPickup(),
                            text: 'Arrived at pickup location',
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Chat button (floating)
          Positioned(
            right: 16.w,
            bottom: 80.h, // Positioned above the fixed bottom button
            child: FloatingActionButton(
              onPressed: () {
                
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.chat, color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String text,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: textColor ?? Colors.black,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
