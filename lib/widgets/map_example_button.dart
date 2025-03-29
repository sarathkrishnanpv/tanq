// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tanq.driver.app/screens/ride_details/live_map_screen.dart';

// class MapExampleButton extends StatelessWidget {
//   final String rideId;
//   final String pickup;
//   final String destination;
//   final Color? buttonColor;

//   const MapExampleButton({
//     Key? key,
//     required this.rideId,
//     required this.pickup,
//     required this.destination,
//     this.buttonColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () {
//         Get.to(
//           () => LiveMapScreen(
//             rideId: rideId,
//             pickup: pickup,
//             destination: destination,
//           ),
//           transition: Transition.rightToLeft,
//           duration: const Duration(milliseconds: 300),
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor ?? Colors.blue,
//         foregroundColor: Colors.white,
//         padding: EdgeInsets.symmetric(
//           horizontal: 16.w,
//           vertical: 12.h,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 2,
//       ),
//       icon: const Icon(Icons.map),
//       label: const Text('View Map'),
//     );
//   }
// } 