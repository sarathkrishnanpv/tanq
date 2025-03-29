import 'package:get/get.dart';

class RideHistoryController extends GetxController {
  // Original unfiltered list
  final RxList<Map<String, dynamic>> _allRides = <Map<String, dynamic>>[
    {
      'id': 'TXN-13451',
      'pickupLocation': 'Kovalam Beach',
      'dropoffLocation': 'Thycaud Bakery Junction',
      'date': DateTime(2024, 3, 15, 12, 47), // Actual DateTime object
      'fare': 482.00,
      'status': 'completed',
    },
    {
      'id': 'TXN-13452',
      'pickupLocation': 'Technopark Phase 1',
      'dropoffLocation': 'Kazhakkoottam',
      'date': DateTime(2024, 3, 14, 15, 30), // Actual DateTime object
      'fare': 350.00,
      'status': 'completed',
    },
    {
      'id': 'TXN-13453',
      'pickupLocation': 'Medical College',
      'dropoffLocation': 'East Fort',
      'date': DateTime(2024, 3, 14, 10, 15), // Actual DateTime object
      'fare': 275.50,
      'status': 'completed',
    }
  ].obs;

  // Filtered list that's displayed
  final RxList<Map<String, dynamic>> rideHistory = <Map<String, dynamic>>[].obs;

  // Selected date for filtering
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize with all rides
    rideHistory.value = _allRides.toList();
  }

  // Filter rides by date
  void filterByDate(DateTime date) {
    selectedDate.value = date;
    
    // Filter rides for the selected date
    final filteredRides = _allRides.where((ride) {
      final rideDate = ride['date'] as DateTime;
      return rideDate.year == date.year &&
             rideDate.month == date.month &&
             rideDate.day == date.day;
    }).toList();

    rideHistory.value = filteredRides;
  }

  // Load more ride history
  Future<void> loadMoreHistory() async {
    // TODO: Implement pagination with actual API call
    // For now, we'll just simulate loading more items
    final moreRides = [
      {
        'id': 'TXN-13454',
        'pickupLocation': 'Pattom',
        'dropoffLocation': 'Kesavadasapuram',
        'date': DateTime(2024, 3, 13, 18, 20),
        'fare': 180.00,
        'status': 'completed',
      },
      {
        'id': 'TXN-13455',
        'pickupLocation': 'Vellayambalam',
        'dropoffLocation': 'Palayam',
        'date': DateTime(2024, 3, 13, 16, 45),
        'fare': 150.00,
        'status': 'completed',
      }
    ];

    _allRides.addAll(moreRides);
    if (selectedDate.value != null) {
      filterByDate(selectedDate.value!);
    } else {
      rideHistory.addAll(moreRides);
    }
  }

  // Clear date filter
  void clearDateFilter() {
    selectedDate.value = null;
    rideHistory.value = _allRides.toList();
  }
} 