// import 'dart:developer';

// import 'package:flutter/widgets.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';

// RxBool isFetchingLocation = false.obs;
// RxDouble latitude = 0.0.obs;
// RxDouble longitude = 0.0.obs;
// RxDouble latitudeto = 0.0.obs;
// RxDouble longitudeto = 0.0.obs;
// RxString city = "".obs;
// RxString state = "".obs;
// TextEditingController locationSearch = TextEditingController();
// Future<void> handleLocation() async {
//   isFetchingLocation.value = true;

//   try {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _handleLocationError('Location services are disabled');
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _handleLocationError('Location permission denied');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // _showLocationSettingsDialog();
//       return;
//     }

//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       await _getCurrentLocation();
//     }
//   } catch (e) {
//     _handleLocationError('Error getting location: $e');
//   } finally {
//     isFetchingLocation.value = false;
//   }
// }

// Future<void> _getCurrentLocation() async {
//   try {
//     final position = await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//       ),
//     );

//     latitude.value = position.latitude;
//     longitude.value = position.longitude;

//     await _updateLocationDetails();
//   } catch (e) {
//     _handleLocationError('Error getting current location: $e');
//   }
// }

// Future<void> _updateLocationDetails() async {
//   try {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latitude.value, longitude.value);
//     if (placemarks.isNotEmpty) {
//       city.value = placemarks[0].street ?? '';
//       state.value = placemarks[0].locality ?? '';
//       locationSearch.text = "${city.value},${state.value}";

//       log("Location updated: ${locationSearch.text}");
//     }
//   } catch (e) {
//     log("Error in reverse geocoding: $e");
//   }
// }

// void _handleLocationError(String message) {
//   log(message);
//   // toastmsgTop(message);
// }
