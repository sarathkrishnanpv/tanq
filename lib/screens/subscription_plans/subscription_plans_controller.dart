import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/widgets/date_picker_dialog.dart' as custom;

class SubscriptionPlan {
  final String duration;
  final int price;
  final int daysValid;
  final int savePercentage;

  SubscriptionPlan({
    required this.duration,
    required this.price,
    required this.daysValid,
    required this.savePercentage,
  });
}

class SubscriptionPlansController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final dateFormat = DateFormat('EEE, MMM d');
  
  // Returns formatted selected date string
  String get formattedDate => dateFormat.format(selectedDate.value);
  
  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      duration: '1 Month',
      price: 100,
      daysValid: 30,
      savePercentage: 0,
    ),
    SubscriptionPlan(
      duration: '3 Month',
      price: 270,
      daysValid: 90,
      savePercentage: 10,
    ),
    SubscriptionPlan(
      duration: '6 Month',
      price: 480,
      daysValid: 180,
      savePercentage: 20,
    ),
    SubscriptionPlan(
      duration: '12 Month',
      price: 840,
      daysValid: 365,
      savePercentage: 30,
    ),
  ];
  
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
  
  SubscriptionPlan getSelectedPlan() {
    return plans[selectedTabIndex.value];
  }
  
  void showDatePickerDialog() {
    Get.dialog(
      custom.DatePickerDialog(
        initialDate: selectedDate.value,
        onDateSelected: (date) {
          selectedDate.value = date;
          subscribeToPlan(getSelectedPlan());
        },
      ),
    );
  }
  
  void subscribeToPlan(SubscriptionPlan plan) {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: Text('Subscribe to ${plan.duration} Plan'),
        content: Text('You will be charged ₹${plan.price} for ${plan.duration} subscription on ${formattedDate}. Proceed?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Show success dialog (simulating payment)
              Future.delayed(Duration(seconds: 1), () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Subscription Successful'),
                    content: Text('Your ${plan.duration} subscription is now active.'),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                  barrierDismissible: false,
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: Text('Proceed'),
          ),
        ],
      ),
    );
  }
  
  void contactUs() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '9876543210');
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not launch phone app',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 