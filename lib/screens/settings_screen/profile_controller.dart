import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/questionnaire/aadhar_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/drivers_license_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/insurance_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pan_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pcc_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/permit_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pollution_certificate_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/rc_book_screen.dart';

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
    switch (documentId) {
      case 'drivers_license':
        Get.to(() => DriversLicenseScreen());
        break;
      case 'rc_book':
        Get.to(() => RCBookScreen());
        break;
      case 'police_clearance':
        Get.to(() => PCCScreen());
        break;
      case 'vehicle_pollution':
        Get.to(() => PollutionCertificateScreen());
        break;
      case 'vehicle_insurance':
        Get.to(() => InsuranceScreen());
        break;
      case 'vehicle_permit':
        Get.to(() => PermitScreen());
        break;
      case 'aadhar_card':
        Get.to(() => AadharScreen());
        break;
      case 'pan_card':
        Get.to(() => PANScreen());
        break;
      default:
        print('No specific screen for: $documentId');
    }
  }
} 