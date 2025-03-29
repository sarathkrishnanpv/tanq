import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // List of notifications
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[
    {
      'id': '1',
      'type': 'transaction',
      'title': 'Transaction Successful!',
      'message': 'Your payment has been credited successfully for Ride ID [12345]. You can check your balance for confirmation. The amount will reflect in 24 hours.',
      'date': DateTime(2024, 11, 12, 19, 30),
      'isNew': true,
      'rideId': '12345',
    },
    {
      'id': '2',
      'type': 'ride_request',
      'title': 'New ride request',
      'message': 'Your payment has been credited successfully for Ride ID [12345]. You can check your balance for confirmation. The amount will reflect in 24 hours.',
      'date': DateTime(2024, 11, 12, 19, 30),
      'isNew': true,
      'rideId': '12345',
    },
  ].obs;

  // Function to mark notification as read
  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((notif) => notif['id'] == notificationId);
    if (index != -1) {
      final notification = notifications[index];
      notification['isNew'] = false;
      notifications[index] = notification;
    }
  }

  // Function to mark all notifications as read
  void markAllAsRead() {
    for (var i = 0; i < notifications.length; i++) {
      final notification = notifications[i];
      notification['isNew'] = false;
      notifications[i] = notification;
    }
  }
  
  // Function to clear all notifications
  void clearAllNotifications() {
    notifications.clear();
  }
} 