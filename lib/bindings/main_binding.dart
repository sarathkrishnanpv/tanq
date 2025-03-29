import 'package:get/get.dart';
import '../screens/main_controller.dart';
import '../screens/notifications_screen/notifications_controller.dart';
import '../controllers/location_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController(), permanent: true);
    Get.put(MainController());
    Get.put(LocationController(), permanent: true);
  }
} 