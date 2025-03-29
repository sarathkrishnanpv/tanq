import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/ride_details/ride_completed_screen.dart';
// Temporarily commenting out Google Maps imports
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  // Navigation
  final RxInt selectedNavIndex = 0.obs;
  
  // Carousel index
  final RxInt currentCarouselIndex = 0.obs;
  
  // Driver status
  final RxBool isOnline = false.obs;
  final RxBool isRideRequested = false.obs;
  final RxBool isRideAccepted = false.obs;
  final RxBool isRideInProgress = false.obs;
  
  // Map related - temporarily using dummy data
  // Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  // final Rx<CameraPosition> initialCameraPosition = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // ).obs;
  
  // Driver stats
  final RxDouble todayEarnings = 1472.78.obs;
  final RxInt totalRides = 0.obs;
  final RxDouble rating = 4.8.obs;
  final RxInt completionRate = 95.obs;
  
  // Recent rides
  final RxList<Map<String, dynamic>> recentRides = <Map<String, dynamic>>[
    {
      'id': '13451234',
      'passengerName': 'John Doe',
      'pickupLocation': 'Kovalam Beach',
      'dropoffLocation': 'Thycaud Bakery Junction',
      'fare': 482.00,
      'date': DateTime(2024, 11, 12, 12, 47),
      'status': 'completed',
    },
    {
      'id': '13451122',
      'passengerName': 'Jane Smith',
      'pickupLocation': 'Technopark',
      'dropoffLocation': 'Shanghumugham Beach',
      'fare': 180.75,
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'status': 'completed',
    },
    {
      'id': '13450987',
      'passengerName': 'Robert Johnson',
      'pickupLocation': 'Trivandrum Central',
      'dropoffLocation': 'Kochuveli Railway Station',
      'fare': 320.20,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'completed',
    },
  ].obs;
  
  // Current ride details (if any)
  final Rx<Map<String, dynamic>?> currentRide = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    // Simulate a ride request after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      simulateRideRequest();
    });
  }
  
  @override
  void onClose() {
    // Temporarily disabled
    // mapController.value?.dispose();
    super.onClose();
  }
  
  // Navigation
  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }
  
  // Temporarily disabled
  // void onMapCreated(GoogleMapController controller) {
  //   mapController.value = controller;
  // }
  
  // Temporarily disabled
  // Future<void> _getCurrentLocation() async {
  //   try {
  //     final permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       await Geolocator.requestPermission();
  //     }
  //     
  //     final position = await Geolocator.getCurrentPosition();
  //     final newPosition = CameraPosition(
  //       target: LatLng(position.latitude, position.longitude),
  //       zoom: 15,
  //     );
  //     
  //     initialCameraPosition.value = newPosition;
  //     
  //     if (mapController.value != null) {
  //       await mapController.value!.animateCamera(
  //         CameraUpdate.newCameraPosition(newPosition),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error getting current location: $e');
  //   }
  // }
  
  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
  
  void acceptRide() {
    isRideRequested.value = false;
    isRideAccepted.value = true;
    // Set current ride details
    currentRide.value = {
      'id': '${recentRides.length + 1}',
      'passengerName': 'New Passenger',
      'pickupLocation': 'Kovalam Beach',
      'dropoffLocation': 'Thycaud Bakery Junction',
      'fare': 225.50,
      'date': DateTime.now(),
      'status': 'accepted',
    };
  }
  
  void startRide() {
    isRideAccepted.value = false;
    isRideInProgress.value = true;
    if (currentRide.value != null) {
      currentRide.value!['status'] = 'in_progress';
    }
  }
  
  void completeRide() {
    isRideInProgress.value = false;
    if (currentRide.value != null) {
      final fare = currentRide.value!['fare'] as double;
      currentRide.value!['status'] = 'completed';
      recentRides.insert(0, currentRide.value!);
      totalRides.value++;
      todayEarnings.value += fare;
      currentRide.value = null;
      
      // Navigate to ride completion screen
      Get.off(() => RideCompletedScreen(earnings: fare));
    }
  }
  
  void cancelRide({String? reason}) {
    isRideRequested.value = false;
    isRideAccepted.value = false;
    isRideInProgress.value = false;
    currentRide.value = null;
    // Here you can handle the rejection reason, e.g., send to backend
    if (reason != null) {
      print('Ride rejected with reason: $reason');
    }
  }
  
  void simulateRideRequest() {
    isRideRequested.value = true;
  }
} 