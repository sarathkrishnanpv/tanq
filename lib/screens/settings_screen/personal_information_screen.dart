import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalInformationController extends GetxController {
  final RxList<String> selectedLanguages = <String>['Malayalam', 'Hindi', 'English', 'Tamil'].obs;
  
  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }
  
  void navigateToChangeLanguage() {
    // Implement language change navigation
    Get.toNamed('/change-language');
  }
}

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInformationController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              _buildLabel('Name'),
              _buildTextField('James Joshes'),
              SizedBox(height: 20.h),
              
              // Date of birth field
              _buildLabel('Date of birth'),
              _buildDateField('12 Nov 2024'),
              SizedBox(height: 20.h),
              
              // Home address field
              _buildLabel('Home address'),
              _buildTextField('Shop No-5/6/7, Sunflower Tower, Cidco\nRoad, Dadar , Gokhale Rd, Prabhadevi', maxLines: 2),
              SizedBox(height: 20.h),
              
              // Languages section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabel('Languages'),
                  TextButton(
                    onPressed: controller.navigateToChangeLanguage,
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Language chips
              Obx(() => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.selectedLanguages.map((language) => 
                  _buildLanguageChip(
                    language,
                    onDelete: () => controller.removeLanguage(language),
                  ),
                ).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  
  Widget _buildTextField(String initialValue, {int maxLines = 1}) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDateField(String initialValue) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        readOnly: true,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
            ),
          ),
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
  
  Widget _buildLanguageChip(String language, {required VoidCallback onDelete}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: onDelete,
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
} 