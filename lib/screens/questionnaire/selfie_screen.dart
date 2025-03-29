import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import '../../widgets/custom_app_bar.dart';
import 'questionnaire_controller.dart';
import 'bank_details_screen.dart';
import '../verification_waiting_screen.dart';

class SelfieScreen extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();
  final ImagePicker _picker = ImagePicker();

  SelfieScreen({super.key});

  Future<void> _takeSelfie(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        preferredCameraDevice: source == ImageSource.camera ? CameraDevice.front : CameraDevice.rear,
      );
      
      if (image != null) {
        controller.selfieImage.value = image.path;
        controller.validateSelfie();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture selfie. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showImageSourceSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Select Method',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  AppButton(
                    onTap: () {
                      Get.back();
                      _takeSelfie(ImageSource.gallery);
                    },
                    text: 'Upload Image',
                    buttonColor: AppColors.black,
                    icon: true,
                    iconData: const Icon(Icons.photo_library_outlined, color: Colors.white),
                    iconBeforeText: true,
                  ),
                  SizedBox(height: 12.h),
                  AppButton(
                    onTap: () {
                      Get.back();
                      _takeSelfie(ImageSource.camera);
                    },
                    text: 'Open Camera',
                    buttonColor: AppColors.black,
                    icon: true,
                    iconData: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                    iconBeforeText: true,
                  ),
                  SizedBox(height: 16.h),
                  AppButton(
                    onTap: () => Get.back(),
                    text: 'Close',
                    buttonColor: Colors.white,
                    textColor: const Color(0xFF2E2E2E),
                    icon: false,
                    iconData: const SizedBox(),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  void _showRegistrationCompletedSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32.h),
              Text(
                'Registration Completed',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
             SizedBox(width: 160.w,height: 160.w,child: Lottie.asset(Assets.gif.greenTick)),
              
              Text(
                'Details Submitted\nSuccessfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'your profile is sent for verification our executives will check your profile and allows you to take rides within 24 hors',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF0E6A0E).withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppButton(
                  onTap: () {
                    Get.offAll(() => const VerificationWaitingScreen());
                  },
                  text: 'Done',
                  buttonColor:AppColors.black,
                  icon: false,
                  iconData: const SizedBox(),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      isDismissible: false,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Upload Selfie',
        showBackButton: true,
        progressText: '5/5',
        progressValue: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Text(
                'One last thing!\nclick a picture of yourself',
                style: TextStyle(
                  fontSize: 24.sp,
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
                'We are just making sure that\nyou are really logging in.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Threeh(),
            Center(
              child: FadeInDown(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 200),
                child: Obx(() => Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFe8f1ff),
                  ),
                  child: ClipOval(
                    child: controller.selfieImage.value != null
                        ? Image.file(
                            File(controller.selfieImage.value!),
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_outline,
                            size: 80.w,
                            color: Colors.grey[400],
                          ),
                  ),
                )),
              ),
            ),
            const Spacer(),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: Container(
                padding: EdgeInsets.only(bottom: 24.h),
                width: double.infinity,
                child: Obx(() => Column(
                  children: [
                    if (controller.selfieImage.value != null) ...[
                      AppButton(
                        onTap: _showRegistrationCompletedSheet,
                        text: 'Complete Profile',
                        buttonColor: Colors.black,
                        icon: false,
                        iconData: const SizedBox(),
                      ),
                      SizedBox(height: 12.h),
                      AppButton(
                        onTap: _showImageSourceSheet,
                        text: 'Retake',
                        buttonColor: Colors.white,
                        textColor: const Color(0xFF2E2E2E),
                        icon: true,
                        iconData: Icon(Icons.camera_alt_outlined, color: const Color(0xFF2E2E2E)),
                        iconBeforeText: true,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    ] else
                      AppButton(
                        onTap: _showImageSourceSheet,
                        text: 'Take Selfie',
                        buttonColor:AppColors.black,
                        icon: true,
                        iconData: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                        iconBeforeText: true,
                      ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 