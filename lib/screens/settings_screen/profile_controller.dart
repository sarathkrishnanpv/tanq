import 'package:get/get.dart';

class ProfileController extends GetxController {
  // User profile data
  final RxString userName = 'Anandhu S Saran'.obs;
  final RxString profileImagePath = ''.obs;
  
  // Document verification status
  final RxList<Map<String, dynamic>> documents = <Map<String, dynamic>>[
    {
      'id': 'personal_details',
      'title': 'Personal Details',
      'status': 'Details verified',
      'isVerified': true,
      'isError': false,
      'progress': '1/1',
    },
    {
      'id': 'vehicle_info',
      'title': 'Vehicle Information',
      'status': 'Details verified',
      'isVerified': true,
      'isError': false,
      'progress': '1/1',
    },
    {
      'id': 'drivers_license',
      'title': 'Drivers license',
      'status': '2/2 Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '2/2',
    },
    {
      'id': 'rc_book',
      'title': 'RC Book',
      'status': '2/2 Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '2/2',
    },
    {
      'id': 'police_clearance',
      'title': 'Police Clearance Certificate (PCC)',
      'status': '2/2 Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '2/2',
    },
    {
      'id': 'vehicle_pollution',
      'title': 'Vehicle Pollution',
      'status': 'Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '1/1',
    },
    {
      'id': 'vehicle_insurance',
      'title': 'Vehicle Insurance',
      'status': 'Expired',
      'isVerified': false,
      'isError': true,
      'progress': '1/1',
    },
    {
      'id': 'vehicle_permit',
      'title': 'Vehicle Permit',
      'status': 'Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '1/1',
    },
    {
      'id': 'aadhar_card',
      'title': 'Aadhar Card',
      'status': 'Uploaded',
      'isVerified': true,
      'isError': false,
      'progress': '1/1',
    },
  ].obs;
  
  // Function to update profile image
  void updateProfileImage(String path) {
    profileImagePath.value = path;
  }
  
  // Function to navigate to document details
  void viewDocumentDetails(String documentId) {
    // This would navigate to a document details screen
    // For now, it just logs the document ID
    print('Viewing document details for: $documentId');
  }
} 