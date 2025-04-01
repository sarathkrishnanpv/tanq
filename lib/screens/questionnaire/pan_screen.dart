import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanq.driver.app/widgets/image_source_bottom_sheet.dart';

class PANScreen extends StatelessWidget {
  PANScreen({super.key});

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
          'PAN Card',
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
              fileName: controller.panPaths.isNotEmpty && controller.panPaths.length > 0 
                  ? controller.panPaths[0].split('/').last 
                  : '',
              fileSize: '1.1 MB',
              isUploaded: controller.panPaths.isNotEmpty && controller.panPaths.length > 0,
              onUpload: () {
                showImageSourceSheet(
                  context,
                  onImageSelected: (XFile? image) {
                    if (image != null) {
                      if (controller.panPaths.isEmpty) {
                        controller.panPaths.add(image.path);
                      } else if (controller.panPaths.length == 1) {
                        controller.panPaths[0] = image.path;
                      } else {
                        controller.panPaths[0] = image.path;
                      }
                    }
                  },
                );
              },
              onView: () {
                // View image
              },
              onDelete: () {
                if (controller.panPaths.isNotEmpty && controller.panPaths.length > 0) {
                  controller.panPaths.removeAt(0);
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
              fileName: controller.panPaths.length > 1 
                  ? controller.panPaths[1].split('/').last 
                  : '',
              fileSize: '0.9 MB',
              isUploaded: controller.panPaths.length > 1,
              onUpload: () {
                showImageSourceSheet(
                  context,
                  onImageSelected: (XFile? image) {
                    if (image != null) {
                      if (controller.panPaths.isEmpty) {
                        controller.panPaths.add(''); // Add empty front side
                        controller.panPaths.add(image.path);
                      } else if (controller.panPaths.length == 1) {
                        controller.panPaths.add(image.path);
                      } else {
                        controller.panPaths[1] = image.path;
                      }
                    }
                  },
                );
              },
              onView: () {
                // View image
              },
              onDelete: () {
                if (controller.panPaths.length > 1) {
                  controller.panPaths.removeAt(1);
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
            
            // PAN Number Field
            Text(
              'PAN number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter 10-character PAN number',
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
              maxLength: 10,
              textCapitalization: TextCapitalization.characters,
            ),
            SizedBox(height: 8.h),
            
            // Name on PAN Field
            Text(
              'Name as on PAN',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter name as printed on PAN card',
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
                onPressed: controller.panPaths.length >= 2 ? () {
                  controller.panUploaded.value = true;
                  Get.back();
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.panPaths.length >= 2 ? Colors.black : Colors.grey[300],
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
                    color: Colors.brown[50],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.insert_drive_file,
                    color: Colors.brown[600],
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