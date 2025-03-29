import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:math' as math;

class LocationController extends GetxController {
  // Driver's current location
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  
  // Pickup and destination locations
  final Rx<LatLng?> pickupLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);
  
  // Address details
  final RxString pickupAddress = "".obs;
  final RxString destinationAddress = "".obs;
  
  // Route details
  final RxDouble distance = 0.0.obs;
  final RxInt duration = 0.obs;  // in seconds
  final RxDouble fare = 0.0.obs;
  
  // Route points for drawing the route line
  final RxList<LatLng> routePoints = <LatLng>[].obs;
  
  // Status flags
  final RxBool isLocationPermissionGranted = true.obs; // Simulate permission granted
  final RxBool isLoading = false.obs;
  final RxBool isRouteFetched = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Simulate location
    _simulateCurrentLocation();
  }
  
  // Simulate current location (Bangalore coordinates)
  void _simulateCurrentLocation() {
    currentLocation.value = LatLng(12.9716, 77.5946);
  }
  
  // Get the current location (simulated)
  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 500));
      _simulateCurrentLocation();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error getting location: $e');
    }
  }
  
  // Set pickup location (simulated address generation)
  Future<void> setPickupLocation(LatLng location) async {
    pickupLocation.value = location;
    // Simulate address lookup
    await Future.delayed(const Duration(milliseconds: 300));
    pickupAddress.value = "123 Main St, Koramangala, Bangalore";
  }
  
  // Set destination location (simulated address generation)
  Future<void> setDestinationLocation(LatLng location) async {
    destinationLocation.value = location;
    // Simulate address lookup
    await Future.delayed(const Duration(milliseconds: 300));
    destinationAddress.value = "456 Park Ave, Indiranagar, Bangalore";
  }
  
  // Calculate route between pickup and destination
  Future<void> calculateRoute() async {
    if (pickupLocation.value == null || destinationLocation.value == null) {
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Create a dummy route
      _createDummyRoute();
      
      isRouteFetched.value = true;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error calculating route: $e');
    }
  }
  
  // Create a dummy route for demo purposes
  void _createDummyRoute() {
    if (pickupLocation.value == null || destinationLocation.value == null) {
      return;
    }
    
    List<LatLng> points = [];
    LatLng start = pickupLocation.value!;
    LatLng end = destinationLocation.value!;
    
    // Add the start point
    points.add(start);
    
    // Add some intermediate points to create a more realistic route
    double latDiff = end.latitude - start.latitude;
    double lngDiff = end.longitude - start.longitude;
    
    // Add 5 intermediate points
    for (int i = 1; i <= 5; i++) {
      double factor = i / 6.0;
      // Add some randomness to make it look like a real route
      double latOffset = (i % 2 == 0) ? 0.0005 : -0.0005;
      double lngOffset = (i % 3 == 0) ? 0.0005 : -0.0005;
      
      points.add(LatLng(
        start.latitude + (latDiff * factor) + latOffset,
        start.longitude + (lngDiff * factor) + lngOffset,
      ));
    }
    
    // Add the end point
    points.add(end);
    
    // Update route points
    routePoints.value = points;
    
    // Calculate approximate distance and duration
    double distanceInKm = calculateDistance(start, end);
    distance.value = distanceInKm;
    
    // Estimate duration (about 2 minutes per km)
    duration.value = (distanceInKm * 120).toInt();
    
    // Calculate fare (base fare + per km rate)
    double baseFare = 20.0;
    double perKmRate = 12.0;
    fare.value = baseFare + (distanceInKm * perKmRate);
  }
  
  // Calculate straight-line distance between two points
  double calculateDistance(LatLng start, LatLng end) {
    const Distance distance = Distance();
    final double distanceInMeters = distance.as(
      LengthUnit.Meter,
      start,
      end,
    );
    return distanceInMeters / 1000; // Convert to kilometers
  }
} 