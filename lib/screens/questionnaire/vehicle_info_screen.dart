import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/questionnaire/payment_details_screen.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:tanq.driver.app/utils/navigation_utils.dart';

class VehicleInfoScreen extends StatelessWidget {
  VehicleInfoScreen({Key? key}) : super(key: key);

  final controller = Get.find<QuestionnaireController>();

  Widget _buildVehicleTypeItem({
    required BuildContext context,
    required String title,
    required String description,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: isSelected ? Border.all(
              color: const Color(0xFF1c67f2),
              width:2,
            ) : null,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F9FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Image.asset(
                 iconPath,
                
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                              'Vehicle Information',
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
                                '2/5',
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
                          width: MediaQuery.of(context).size.width * (2 / 5),
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
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: const Text(
                        'A few quick details, and you\'re\nready to drive!',
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
                        'Enter details of your vehicles as on proofs.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vehicle Type Selection with Error
                          FadeInDown(
                            duration: const Duration(milliseconds: 400),
                            delay: const Duration(milliseconds: 300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Choose vehicle type',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FadeIn(
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => Container(
                                              height: MediaQuery.of(context).size.height * 0.92,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(16.r),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h),
                                                    child: FadeIn(
                                                      duration: const Duration(milliseconds: 400),
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Select vehicle type',
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => Navigator.pop(context),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 24.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                 
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                      child: Obx(() => Column(
                                                        children: [
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 100),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'Premium car',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6...',
                                                              iconPath: Assets.images.icons.goldcar.path,
                                                              isSelected: controller.vehicleType.value == 'Premium car',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'Premium car';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 150),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'Electric auto',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6, Mercedes E-Class',
                                                              iconPath: Assets.images.icons.electricAutoPng.path,
                                                              isSelected: controller.vehicleType.value == 'Electric auto',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'Electric auto';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 200),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'Auto',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6, Mercedes E-Class',
                                                              iconPath: Assets.images.icons.autoPng.path,
                                                              isSelected: controller.vehicleType.value == 'Auto',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'Auto';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 250),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'Electric car',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6, Mercedes E-Class',
                                                              iconPath: Assets.images.icons.ev.path,
                                                              isSelected: controller.vehicleType.value == 'Electric car',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'Electric car';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 300),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'SUV',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6, Mercedes E-Class',
                                                              iconPath: Assets.images.icons.suvPng.path,
                                                              isSelected: controller.vehicleType.value == 'SUV',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'SUV';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                          FadeInUp(
                                                            duration: const Duration(milliseconds: 400),
                                                            delay: const Duration(milliseconds: 350),
                                                            from: 30,
                                                            child: _buildVehicleTypeItem(
                                                              context: context,
                                                              title: 'Sedan',
                                                              description: 'Luxury cars with top-notch comfort and style. BMW 5 Series, Audi A6, Mercedes E-Class',
                                                              iconPath: Assets.images.icons.sedanPng.path,
                                                              isSelected: controller.vehicleType.value == 'Sedan',
                                                              onTap: () {
                                                                controller.vehicleType.value = 'Sedan';
                                                                controller.vehicleTypeError.value = false;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                  FadeInUp(
                                                    duration: const Duration(milliseconds: 400),
                                                    delay: const Duration(milliseconds: 200),
                                                    from: 30,
                                                    child: Container(
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
                                                            if (controller.vehicleType.value.isNotEmpty) {
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.black,
                                                            padding: EdgeInsets.symmetric(vertical: 16.h),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(4.r),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Continue with ${controller.vehicleType.value}',
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: controller.vehicleTypeError.value 
                                                ? Colors.red 
                                                : Colors.grey[300]!,
                                            ),
                                            borderRadius: BorderRadius.circular(4.r),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                controller.vehicleType.value.isEmpty
                                                    ? 'Select vehicle'
                                                    : controller.vehicleType.value,
                                                style: TextStyle(
                                                  color: controller.vehicleType.value.isEmpty
                                                      ? Colors.grey[600]
                                                      : Colors.black,
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.grey[600],
                                                size: 20.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (controller.vehicleTypeError.value)
                                      FadeInLeft(
                                        duration: const Duration(milliseconds: 400),
                                        delay: const Duration(milliseconds: 100),
                                        from: 30,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                          child: Text(
                                            controller.vehicleTypeErrorText.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Vehicle Model Name with Error
                          FadeInDown(
                            duration: const Duration(milliseconds: 400),
                            delay: const Duration(milliseconds: 400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vehicle Model name',
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
                                      onChanged: (value) {
                                        controller.vehicleModel.value = value;
                                        controller.vehicleModelError.value = false;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Enter model name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4.r),
                                          borderSide: BorderSide(
                                            color: controller.vehicleModelError.value 
                                              ? Colors.red 
                                              : Colors.grey[300]!,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4.r),
                                          borderSide: BorderSide(
                                            color: controller.vehicleModelError.value 
                                              ? Colors.red 
                                              : Colors.grey[300]!,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4.r),
                                          borderSide: BorderSide(
                                            color: controller.vehicleModelError.value 
                                              ? Colors.red 
                                              : Colors.grey[300]!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (controller.vehicleModelError.value)
                                      FadeInLeft(
                                        duration: const Duration(milliseconds: 400),
                                        delay: const Duration(milliseconds: 100),
                                        from: 30,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                          child: Text(
                                            controller.vehicleModelErrorText.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Year of Manufacture with Error
                          FadeInDown(
                            duration: const Duration(milliseconds: 400),
                            delay: const Duration(milliseconds: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Year of manufacture',
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
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime.now(),
                                        );
                                        if (picked != null) {
                                          controller.vehicleYear.value = picked.year.toString();
                                          controller.vehicleYearError.value = false;
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: controller.vehicleYearError.value 
                                              ? Colors.red 
                                              : Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              controller.vehicleYear.value.isEmpty
                                                  ? 'Select vehicle'
                                                  : controller.vehicleYear.value,
                                              style: TextStyle(
                                                color: controller.vehicleYear.value.isEmpty
                                                    ? Colors.grey[600]
                                                    : Colors.black,
                                              ),
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: Colors.grey[600],
                                              size: 20.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (controller.vehicleYearError.value)
                                      FadeInLeft(
                                        duration: const Duration(milliseconds: 400),
                                        delay: const Duration(milliseconds: 100),
                                        from: 30,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4.h, left: 4.w),
                                          child: Text(
                                            controller.vehicleYearErrorText.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Upload Vehicle Images
                          FadeInDown(
                            duration: const Duration(milliseconds: 400),
                            delay: const Duration(milliseconds: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Upload Vehicle image',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F9FF),
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            // Handle image upload
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(vertical: 16.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Upload',
                                                style: TextStyle(
                                                  color: const Color(0xFF1c67f2),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: const Color(0xFF1c67f2),
                                                size: 16.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: Text(
                                    'Maximum file size 5 MB',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
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
               
                    NavigationUtils.pushWithSlideTransition(
                      context,
                      PaymentDetailsScreen(),
                    );
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
} 