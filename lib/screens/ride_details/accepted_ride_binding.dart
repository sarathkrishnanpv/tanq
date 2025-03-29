import 'package:get/get.dart';
import 'accepted_ride_screen.dart';

class AcceptedRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptedRideController>(() => AcceptedRideController());
  }
} 