import 'package:get/get.dart';
import 'notifications_screen/notifications_controller.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxInt unreadNotificationsCount = 99.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Get the notifications controller to monitor unread notifications
    ever(Get.find<NotificationsController>().notifications, (_) {
      updateUnreadCount();
    });
  }
  
  void changeTab(int index) {
    selectedIndex.value = index;
    
    // Clear notification count when navigating to notifications tab
    if (index == 2) {
      // Get.find<NotificationsController>().markAllAsRead();
      // We're not marking all as read to keep the 99+ indicator visible for demonstration
    }
  }
  
  void updateUnreadCount() {
    // For demonstration purposes, we're keeping it at 99+
    // In a real app, you would calculate this from the notifications list:
    // final unreadCount = Get.find<NotificationsController>().notifications
    //    .where((notification) => notification['isNew'] == true).length;
    // unreadNotificationsCount.value = unreadCount;
    unreadNotificationsCount.value = 99;
  }
} 