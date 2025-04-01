import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/navigation_utils.dart';
import 'package:tanq.driver.app/screens/questionnaire/vehicle_documents_screen.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({Key? key}) : super(key: key);

  final controller = Get.find<QuestionnaireController>();

  @override
  Widget build(BuildContext context) {
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
                              'Payment Details',
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
                                '3/5',
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
                          width: MediaQuery.of(context).size.width * (3 / 7),
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
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: const Text(
                        'These details are for your ride\nfee transaction',
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
                        'Make sure that you are filling the correct details.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Bank Account Details Section
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 200),
                      child: const Text(
                        'BANK ACCOUNT DETAILS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Bank Name Field
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bank Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => TextFormField(
                            onChanged: (value) {
                              controller.bankName.value = value;
                              controller.bankNameError.value = false;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter bank name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.bankNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.bankNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.bankNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                            ),
                          )),
                          if (controller.bankNameError.value)
                            FadeInLeft(
                              duration: const Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                child: Text(
                                  controller.bankNameErrorText.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Beneficiary Name Field
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 275),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Beneficiary Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => TextFormField(
                            onChanged: (value) {
                              controller.beneficiaryName.value = value;
                              controller.beneficiaryNameError.value = false;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter name as in bank account',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.beneficiaryNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.beneficiaryNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.beneficiaryNameError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                            ),
                          )),
                          if (controller.beneficiaryNameError.value)
                            FadeInLeft(
                              duration: const Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                child: Text(
                                  controller.beneficiaryNameErrorText.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Account Number Field
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Number',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => TextFormField(
                            onChanged: (value) {
                              controller.accountNumber.value = value;
                              controller.accountNumberError.value = false;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter account number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.accountNumberError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.accountNumberError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.accountNumberError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                            ),
                          )),
                          if (controller.accountNumberError.value)
                            FadeInLeft(
                              duration: const Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                child: Text(
                                  controller.accountNumberErrorText.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // IFSC Code Field
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 350),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'IFSC Code',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(() => TextFormField(
                            onChanged: (value) {
                              controller.ifscCode.value = value.toUpperCase();
                              controller.ifscCodeError.value = false;
                            },
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              hintText: 'Enter IFSC code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.ifscCodeError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.ifscCodeError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                borderSide: BorderSide(
                                  color: controller.ifscCodeError.value 
                                    ? Colors.red 
                                    : Colors.grey[300]!,
                                ),
                              ),
                            ),
                          )),
                          if (controller.ifscCodeError.value)
                            FadeInLeft(
                              duration: const Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                child: Text(
                                  controller.ifscCodeErrorText.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
           Twoh(),
                     Padding(  padding: EdgeInsets.all(16.w),
                       child: AppButton(
                                   iconData: SizedBox.shrink(),
                                   onTap: () {
                                     if (controller.validatePaymentDetails()) {
                                       controller.nextStep();
                                       NavigationUtils.pushWithSlideTransition(
                                         context,
                                         VehicleDocumentsScreen(),
                                       );
                                     }
                                   },
                                   text: 'Continue',
                                 ),
                     ),
         ],
      ),
    );
  }
} 