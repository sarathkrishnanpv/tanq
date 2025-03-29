import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:tanq.driver.app/screens/questionnaire/vehicle_info_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final QuestionnaireController controller = Get.find<QuestionnaireController>();
  final List<String> languageOptions = [
    'Malayalam',
    'Tamil',
    'Telugu',
    'Kannada',
  ];

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Column(
          children: [
            // Status bar height
            SizedBox(height: MediaQuery.of(context).padding.top),
            // App bar content
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Back button and title row
                  SizedBox(
                    height: 56.h,
                    child: Row(
                      children: [
                        SizedBox(width: 4.w),
                        // Back button
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(width: 8.w),
                        // Title and step indicator
                        Row(
                          children: [
                            Text(
                              'Personal Information',
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
                                '1/5',
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
                  // Progress bar
                  Container(
                    height: 2.h,
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * (1 / 5),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        'Tell us about yourself',
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
                        'We need some basic information to get started.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name field
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                onChanged: (value) => controller.validateName(value),
                                decoration: InputDecoration(
                                  hintText: 'Enter your full name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.nameHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.nameHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.nameHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                ),
                              ),
                              if (controller.nameHasError.value)
                                Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    controller.nameError.value,
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                          SizedBox(height: 16.h),

                          // Date of birth field
                          const Text(
                            'Date of birth',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                                    firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    controller.validateDateOfBirth(picked);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: controller.dateOfBirthHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.dateOfBirth.value != null
                                            ? '${controller.dateOfBirth.value!.day} ${_getMonth(controller.dateOfBirth.value!.month)} ${controller.dateOfBirth.value!.year}'
                                            : 'Select date of birth',
                                        style: TextStyle(
                                          color: controller.dateOfBirth.value != null
                                              ? Colors.black
                                              : Colors.grey[600],
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: controller.dateOfBirthHasError.value 
                                          ? const Color(0xFFE53935) 
                                          : Colors.grey[600],
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (controller.dateOfBirthHasError.value)
                                Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    controller.dateOfBirthError.value,
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                          SizedBox(height: 16.h),

                          // Home address field
                          const Text(
                            'Home address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                onChanged: (value) => controller.validateHomeAddress(value),
                                decoration: InputDecoration(
                                  hintText: 'Enter your complete address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.homeAddressHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.homeAddressHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    borderSide: BorderSide(
                                      color: controller.homeAddressHasError.value 
                                        ? const Color(0xFFE53935) 
                                        : Colors.grey[300]!,
                                    ),
                                  ),
                                ),
                                maxLines: 3,
                              ),
                              if (controller.homeAddressHasError.value)
                                Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    controller.homeAddressError.value,
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                          SizedBox(height: 16.h),

                          // Languages field
                          Text(
                            'Languages',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.hasLanguageError.value 
                                  ? Colors.red 
                                  : Colors.grey[300]!,
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                isExpanded: true,
                                hint: Text(
                                  'Select language',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                items: languageOptions
                                    .where((language) => !controller.selectedLanguages.contains(language))
                                    .map((String language) {
                                  return DropdownMenuItem<String>(
                                    value: language,
                                    child: Text(
                                      language,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    controller.addLanguage(value);
                                  }
                                },
                              ),
                            ),
                          )),
                          SizedBox(height: 12.h),
                          Obx(() => Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: controller.selectedLanguages.map((language) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      language,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    GestureDetector(
                                      onTap: () => controller.removeLanguage(language),
                                      child: Icon(
                                        Icons.close,
                                        size: 16.w,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )),
                          Obx(() {
                            if (controller.hasLanguageError.value) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  controller.languageErrorText.value,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.nextStep();
                  Get.to(() => VehicleInfoScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
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
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
} 