import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/utils/bottom_sheet_utils.dart';
import 'dart:async';
import 'accepted_ride_screen.dart';
import 'package:tanq.driver.app/utils/animated_dotted_line.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NewRideDetailsController extends GetxController {
  final RxInt remainingSeconds = 60.obs;
  Timer? _timer;
  
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
  
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        // Auto reject ride when timer expires
        Get.back();
      }
    });
  }
  
  void acceptRide() {
    _timer?.cancel();
    // Navigate to AcceptedRideScreen instead of just going back
   Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => AcceptedRideScreen()));
  }
  
  void rejectRide({String? reason}) {
    _timer?.cancel();
    Get.back(result: false);
  }
}

class NewRideDetailsScreen extends StatelessWidget {
  const NewRideDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewRideDetailsController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'New ride details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Map section with enhanced elements
          SizedBox(
            width: double.infinity,
            height: 200.h,
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
                        LatLng(8.5241, 76.9366), // Starting point (user location)
                        LatLng(8.5270, 76.9400), // Via point
                        LatLng(8.5300, 76.9450), // Destination
                      ],
                      color: Colors.blue,
                      strokeWidth: 3.0,
                    ),
                  ],
                ),
                // Markers layer
                MarkerLayer(
                  markers: [
                    // Pickup marker
                    Marker(
                      width: 60.w,
                      height: 60.h,
                      point: LatLng(8.5241, 76.9366),
                      child: Column(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
                            child: const Text(
                              'Pickup',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Dropoff marker
                    Marker(
                      width: 60.w,
                      height: 60.h,
                      point: LatLng(8.5300, 76.9450),
                      child: Column(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
                            child: const Text(
                              'Dropoff',
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
          
          // Content section - Expanded with scrollview to take all available space
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ride overview section
                  _buildSectionHeader(
                    'RIDE OVERVIEW',
                    trailing: Obx(() => _buildCountdownTimer(controller.remainingSeconds.value)),
                  ),
                  SizedBox(height: 8.h),
                  
                  // Pickup and dropoff locations
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          // Pickup location
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'PICKUP LOCATION',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  const Text(
                                    'Thycaud',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  const Text(
                                    '2KM away from you',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                       
                          // Dropoff location
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DROP OFF LOCATION',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  const Text(
                                    'Thiruvananthapuram',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Distance & Payment
                  _buildSectionHeader('DISTANCE & PAYMENT'),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Payment amount
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹ ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '68.00',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              const Text(
                                'Pay for Ride',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Distance
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '12.4 KM',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              const Text(
                                'Total travel distance',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Passenger details
                  _buildSectionHeader('PASSENGER DETAILS'),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      children: [
                        // Passenger avatar
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: const AssetImage('assets/images/normal/user.png'),
                        ),
                        SizedBox(width: 12.w),
                        // Passenger name
                        const Text(
                          'Ramesh Jain',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Add some bottom padding to ensure content isn't hidden behind buttons
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
          
          // Bottom action buttons - Fixed at bottom
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.r),
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Reject button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final reason = await BottomSheetUtils.showRejectionReasonSheet();
                      if (reason != null) {
                        controller.rejectRide(reason: reason);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: const Text(
                      'Reject Ride',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Accept button
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.acceptRide,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: const Text(
                      'Accept ride',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
  
  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
  
  Widget _buildCountdownTimer(int seconds) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:
      8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time_filled,
            color: Colors.white,
            size: 14,
          ),
          SizedBox(width: 4.w),
          Text(
            '$seconds Sec',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper widget to create location markers on the map
  Widget _buildLocationMarker({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 