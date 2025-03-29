import 'package:get/get.dart';
import 'new_ride_details_screen.dart';

class NewRideDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewRideDetailsController>(() => NewRideDetailsController());
  }
} 