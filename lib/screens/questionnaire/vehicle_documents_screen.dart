import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/navigation_utils.dart';
import 'package:tanq.driver.app/screens/questionnaire/selfie_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/drivers_license_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/rc_book_screen.dart';

class VehicleDocumentsScreen extends StatelessWidget {
  VehicleDocumentsScreen({Key? key}) : super(key: key);

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
                            NavigationUtils.pop(context);
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
                              'Upload Documents',
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
                                color: const Color(0xFF1c67f2),
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
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: () {
                                // Show help dialog
                              },
                              icon: Icon(
                                Icons.help_outline,
                                color: Colors.grey[600],
                                size: 24.sp,
                              ),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
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
                          width: MediaQuery.of(context).size.width * (4 / 7),
                          color: const Color(0xFF1c67f2),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: const Text(
                        'Upload your documents!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 100),
                      child: Text(
                        'We are just making sure that you are really logging in.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    
                    // Document List
                    Obx(() => Column(
                      children: [
                        _buildDocumentItem(
                          title: 'Driver\'s License',
                          isUploaded: controller.driversLicenseUploaded.value,
                          onTap: () {
                            controller.uploadDriversLicense();
                            Get.to(() => DriversLicenseScreen());
                          },
                        ),
                        _buildDocumentItem(
                          title: 'RC Book',
                          isUploaded: controller.rcBookUploaded.value,
                          onTap: () {
                            controller.uploadRCBook();
                            Get.to(() => RCBookScreen());
                          },
                        ),
                        _buildDocumentItem(
                          title: 'Police Clearance Certificate (PCC)',
                          isUploaded: controller.pccUploaded.value,
                          onTap: () => controller.uploadPCC(),
                        ),
                        _buildDocumentItem(
                          title: 'Vehicle Pollution',
                          isUploaded: controller.pollutionUploaded.value,
                          onTap: () => controller.uploadPollution(),
                        ),
                        _buildDocumentItem(
                          title: 'Vehicle Insurance',
                          isUploaded: controller.insuranceUploaded.value,
                          onTap: () => controller.uploadInsurance(),
                        ),
                        _buildDocumentItem(
                          title: 'Vehicle Permit',
                          isUploaded: controller.permitUploaded.value,
                          onTap: () => controller.uploadPermit(),
                        ),
                        _buildDocumentItem(
                          title: 'Aadhar Card',
                          isUploaded: controller.aadharUploaded.value,
                          onTap: () => controller.uploadAadhar(),
                        ),
                        _buildDocumentItem(
                          title: 'PAN Card',
                          isUploaded: controller.panUploaded.value,
                          onTap: () => controller.uploadPAN(),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 400),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                children: [
                 
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onTap: () {
                        controller.nextStep();
                            NavigationUtils.pushWithSlideTransition(
                              context,
                               SelfieScreen()
                            );
                    
                  }, text: 'Submit', iconData: SizedBox.shrink(),)),
                 SizedBox(height: 16.h),
                  Text(
                    'You can only submit after uploading all the documents',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}   