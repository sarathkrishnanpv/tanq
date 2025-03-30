import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:tanq.driver.app/screens/questionnaire/drivers_license_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/rc_book_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pcc_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pollution_certificate_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/insurance_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/permit_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/aadhar_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/pan_screen.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({Key? key}) : super(key: key);

  final controller = Get.find<QuestionnaireController>();

  Widget _buildDocumentItem({
    required String title,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return FadeInDown(
      duration: const Duration(milliseconds: 400),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isUploaded) ...[
                      SizedBox(width: 8.w),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '2/2 Uploaded',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[600],
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 56.h,
                    child: Row(
                      children: [
                        SizedBox(width: 4.w),
                        IconButton(
                          onPressed: () {
                            controller.previousStep();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(width: 8.w),
                        Row(
                          children: [
                            Text(
                              'Documents',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2196F3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '4/5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2.h,
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * (3 / 5),
                          color: const Color(0xFF2196F3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Required Documents',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please upload all required documents',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => Column(
                  children: [
                    _buildDocumentItem(
                      title: 'Driver\'s License',
                      isUploaded: controller.driversLicenseUploaded.value,
                      onTap: () {
                        Get.to(() => DriversLicenseScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'RC Book',
                      isUploaded: controller.rcBookUploaded.value,
                      onTap: () {
                        Get.to(() => RCBookScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'Police Clearance Certificate (PCC)',
                      isUploaded: controller.pccUploaded.value,
                      onTap: () {
                        Get.to(() => PCCScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'Vehicle Pollution',
                      isUploaded: controller.pollutionUploaded.value,
                      onTap: () {
                        Get.to(() => PollutionCertificateScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'Vehicle Insurance',
                      isUploaded: controller.insuranceUploaded.value,
                      onTap: () {
                        Get.to(() => InsuranceScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'Vehicle Permit',
                      isUploaded: controller.permitUploaded.value,
                      onTap: () {
                        Get.to(() => PermitScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'Aadhar Card',
                      isUploaded: controller.aadharUploaded.value,
                      onTap: () {
                        Get.to(() => AadharScreen());
                      },
                    ),
                    _buildDocumentItem(
                      title: 'PAN Card',
                      isUploaded: controller.panUploaded.value,
                      onTap: () {
                        Get.to(() => PANScreen());
                      },
                    ),
                  ],
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.allDocumentsUploaded
                      ? () => controller.nextStep()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 