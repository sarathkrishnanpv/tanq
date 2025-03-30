import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanq.driver.app/widgets/date_picker_dialog.dart' as custom;

class EarningsController extends GetxController with GetSingleTickerProviderStateMixin {
  // Period selector state (0 = today, 1 = last 7 days)
  final RxInt selectedPeriod = 0.obs;
  
  // Selected date for custom date filtering
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final dateFormat = DateFormat('EEE, MMM d');
  
  // Returns formatted selected date string
  String get formattedDate => dateFormat.format(selectedDate.value);
  
  // TabController for the segmented tab control
  late TabController tabController;
  
  // Total earnings amount
  final RxDouble totalEarnings = 1472.78.obs;
  
  // Transaction list
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[
    {
      'id': '1',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '2',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '3',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '4',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
  ].obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController(initialPage: 0);

    // Sync tab selection with page view
    tabController.addListener(() {
      selectedPeriod.value = tabController.index;
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    // Load initial data
    loadTransactions();
  }
  
  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
    super.onClose();
  }
  
  void showDatePickerDialog() {
    Get.dialog(
      custom.DatePickerDialog(
        initialDate: selectedDate.value,
        onDateSelected: (date) {
          selectedDate.value = date;
          // Switch to custom date mode (if not already in a custom mode)
          if (selectedPeriod.value < 2) {
            selectedPeriod.value = 2; // Custom date period
          }
          loadTransactionsForSelectedDate();
        },
      ),
    );
  }
  
  void loadTransactionsForSelectedDate() {
    // In a real app, you would filter transactions for the selected date
    // For now, we'll just update the transactions list with the same data
    loadTransactions();
  }
  
  void loadTransactions() {
    // Add your transaction loading logic here
    transactions.value = [
       {
      'id': '1',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '2',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '3',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    {
      'id': '4',
      'customerName': 'Anandhu S',
      'initials': 'TQ',
      'date': DateTime(2024, 11, 12, 19, 30),
      'paymentMethod': 'cash',
      'amount': 482.00,
    },
    ];
  }
} 