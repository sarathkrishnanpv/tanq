import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tanq.driver.app/controllers/location_controller.dart';
import 'package:tanq.driver.app/domain/api_keys.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'dart:async';
import 'dart:math' as math;

class LiveMapScreen extends StatefulWidget {
  final String rideId;
  final String pickup;
  final String destination;

  const LiveMapScreen({
    Key? key,
    required this.rideId,
    required this.pickup,
    required this.destination,
  }) : super(key: key);

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> 
    with SingleTickerProviderStateMixin {
  final LocationController locationController = Get.find<LocationController>();
  final MapController mapController = MapController();
  late AnimationController pulseAnimationController;
  late Timer locationUpdateTimer;
  
  // Default center on Bangalore
  final LatLng defaultCenter = LatLng(12.9716, 77.5946);
  
  @override
  void initState() {
    super.initState();
    
    // Set up a timer to simulate location updates
    locationUpdateTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _simulateLocationUpdate();
    });
    
    // Set up animation for the route pulse effect
    pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // Initialize locations for demo
    _initializeLocations();
  }
  
  void _initializeLocations() {
    // Set demo pickup and destination locations
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Set pickup location (starting with some predefined coordinates)
      await locationController.setPickupLocation(LatLng(12.9716, 77.5946));
      
      // Set destination location
      await locationController.setDestinationLocation(LatLng(12.9819, 77.6100));
      
      // Calculate route
      await locationController.calculateRoute();
      
      // Set initial camera position
      if (locationController.pickupLocation.value != null) {
        mapController.move(
          locationController.pickupLocation.value!,
          14.0,
        );
      }
    });
  }
  
  void _simulateLocationUpdate() {
    if (locationController.routePoints.isEmpty) return;
    
    // Get current location or use the first point of the route if not available
    LatLng currentPos = locationController.currentLocation.value ?? 
                        locationController.routePoints.first;
                        
    // Find the nearest point on the route
    int nearestPointIndex = 0;
    double minDistance = double.infinity;
    
    for (int i = 0; i < locationController.routePoints.length; i++) {
      double dist = locationController.calculateDistance(
        currentPos, 
        locationController.routePoints[i]
      );
      
      if (dist < minDistance) {
        minDistance = dist;
        nearestPointIndex = i;
      }
    }
    
    // Move along the route to the next point
    int nextPointIndex = math.min(
      nearestPointIndex + 1, 
      locationController.routePoints.length - 1
    );
    
    if (nextPointIndex > nearestPointIndex) {
      LatLng nextPoint = locationController.routePoints[nextPointIndex];
      LatLng currentPoint = locationController.routePoints[nearestPointIndex];
      
      // Move 20% of the way from current to next point
      double newLat = currentPoint.latitude + 
                      (nextPoint.latitude - currentPoint.latitude) * 0.2;
      double newLng = currentPoint.longitude + 
                      (nextPoint.longitude - currentPoint.longitude) * 0.2;
      
      // Update current location
      locationController.currentLocation.value = LatLng(newLat, newLng);
    }
  }
  
  @override
  void dispose() {
    pulseAnimationController.dispose();
    locationUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          Obx(() => FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: locationController.currentLocation.value ?? defaultCenter,
              initialZoom: 14.0,
              maxZoom: 18.0,
              minZoom: 8.0,
            ),
            children: [
              // Map tiles layer
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': mapboxAccessToken,
                },
              ),
              
              // Route polyline
              if (locationController.routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: locationController.routePoints,
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
              
              // Animated route effect
              if (locationController.routePoints.isNotEmpty)
                AnimatedBuilder(
                  animation: pulseAnimationController,
                  builder: (context, child) {
                    return PolylineLayer(
                      polylines: [
                        Polyline(
                          points: locationController.routePoints,
                          color: Colors.blue.withOpacity(0.3 * pulseAnimationController.value),
                          strokeWidth: 8.0 * (0.5 + pulseAnimationController.value * 0.5),
                        ),
                      ],
                    );
                  },
                ),
              
              // Location markers
              MarkerLayer(
                markers: [
                  // Current location marker
                  if (locationController.currentLocation.value != null)
                    Marker(
                      point: locationController.currentLocation.value!,
                      width: 60.w,
                      height: 60.h,
                      child: Transform.rotate(
                        angle: 0.5, // Could calculate actual bearing here
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          padding: EdgeInsets.all(4.r),
                          child: const Icon(
                            Icons.directions_car,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  
                  // Pickup marker
                  if (locationController.pickupLocation.value != null)
                    Marker(
                      point: locationController.pickupLocation.value!,
                      width: 50.w,
                      height: 60.h,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                            ),
                            padding: EdgeInsets.all(4.r),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 0,
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
                  
                  // Destination marker
                  if (locationController.destinationLocation.value != null)
                    Marker(
                      point: locationController.destinationLocation.value!,
                      width: 50.w,
                      height: 60.h,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                            ),
                            padding: EdgeInsets.all(4.r),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Text(
                              'Destination',
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
          )),
          
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: 8.h,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Live Trip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (locationController.currentLocation.value != null) {
                        mapController.move(
                          locationController.currentLocation.value!,
                          15.0,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom info panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ride details section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: const AssetImage('assets/images/normal/user.png'),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ramesh Jain',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Obx(() => Text(
                              locationController.isRouteFetched.value
                                ? 'Trip to ${widget.destination}'
                                : 'Loading trip details...',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            )),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          // Handle call passenger
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: Colors.blue,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          // Handle message passenger
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Route and payment info
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Distance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.map,
                                size: 16.sp,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${locationController.distance.value.toStringAsFixed(1)} KM',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Distance',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      
                      // ETA
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16.sp,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${(locationController.duration.value / 60).ceil()} min',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'ETA',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      
                      // Fare
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                size: 16.sp,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${locationController.fare.value.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Total fare',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                  
                  SizedBox(height: 16.h),
                  
                  // Ride status button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle arrival at destination
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'I have arrived at destination',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Loading indicator
          Obx(() => locationController.isLoading.value
            ? Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink()
          ),
        ],
      ),
    );
  }
} 