import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanq.driver.app/widgets/image_source_bottom_sheet.dart';

class AadharScreen extends StatelessWidget {
  AadharScreen({super.key});

  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Aadhar Card',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPLOAD',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            
            // Front Side Upload
            Text(
              'Front Side',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() => _buildUploadItem(
              fileName: controller.aadharPaths.isNotEmpty && controller.aadharPaths.length > 0 
                  ? controller.aadharPaths[0].split('/').last 
                  : '',
              fileSize: '1.2 MB',
              isUploaded: controller.aadharPaths.isNotEmpty && controller.aadharPaths.length > 0,
              onUpload: () {
                showImageSourceSheet(
                  context,
                  onImageSelected: (XFile? image) {
                    if (image != null) {
                      if (controller.aadharPaths.isEmpty) {
                        controller.aadharPaths.add(image.path);
                      } else if (controller.aadharPaths.length == 1) {
                        controller.aadharPaths[0] = image.path;
                      } else {
                        controller.aadharPaths[0] = image.path;
                      }
                    }
                  },
                );
              },
              onView: () {
                // View image
              },
              onDelete: () {
                if (controller.aadharPaths.isNotEmpty && controller.aadharPaths.length > 0) {
                  controller.aadharPaths.removeAt(0);
                }
              },
            )),
            SizedBox(height: 16.h),
            
            // Back Side Upload
            Text(
              'Back Side',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() => _buildUploadItem(
              fileName: controller.aadharPaths.length > 1 
                  ? controller.aadharPaths[1].split('/').last 
                  : '',
              fileSize: '1.0 MB',
              isUploaded: controller.aadharPaths.length > 1,
              onUpload: () {
                showImageSourceSheet(
                  context,
                  onImageSelected: (XFile? image) {
                    if (image != null) {
                      if (controller.aadharPaths.isEmpty) {
                        controller.aadharPaths.add(''); // Add empty front side
                        controller.aadharPaths.add(image.path);
                      } else if (controller.aadharPaths.length == 1) {
                        controller.aadharPaths.add(image.path);
                      } else {
                        controller.aadharPaths[1] = image.path;
                      }
                    }
                  },
                );
              },
              onView: () {
                // View image
              },
              onDelete: () {
                if (controller.aadharPaths.length > 1) {
                  controller.aadharPaths.removeAt(1);
                }
              },
            )),
            
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Upload a PDF, JPEG, or JPG file type only.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              ),
            ),
            
            const Spacer(),
            
            // Details Section
            Text(
              'DETAILS',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            
            // Aadhar Number Field
            Text(
              'Aadhar number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter 12-digit Aadhar number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 12,
            ),
            SizedBox(height: 8.h),
            
            // Name on Aadhar Field
            Text(
              'Name as on Aadhar',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter name as printed on Aadhar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: controller.aadharPaths.length >= 2 ? () {
                  controller.aadharUploaded.value = true;
                  Get.back();
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.aadharPaths.length >= 2 ? Colors.black : Colors.grey[300],
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
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadItem({
    required String fileName,
    required String fileSize,
    required bool isUploaded,
    required VoidCallback onUpload,
    required VoidCallback onView,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: isUploaded
          ? Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.insert_drive_file,
                    color: Colors.orange[600],
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            fileSize,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          GestureDetector(
                            onTap: onView,
                            child: Text(
                              'View',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                  onPressed: onDelete,
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.upload_file,
                    color: Colors.grey[600],
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No file chosen',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'PDF, JPEG, or JPG (Max: 5MB)',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onUpload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    'Browse',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
} 