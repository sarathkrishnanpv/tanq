import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EarningsController extends GetxController with GetSingleTickerProviderStateMixin {
  // Period selector state (0 = today, 1 = last 7 days)
  final RxInt selectedPeriod = 0.obs;
  
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