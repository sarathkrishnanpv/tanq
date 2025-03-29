import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/screens/questionnaire/questionnaire_controller.dart';
import 'package:image_picker/image_picker.dart';

class RCBookScreen extends StatelessWidget {
  RCBookScreen({super.key});

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
          'RC Book',
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
              fileName: controller.rcBookFront.value,
              fileSize: '1.3 MB',
              isUploaded: controller.rcBookFront.value.isNotEmpty,
              onUpload: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.rcBookFront.value = image.path.split('/').last;
                }
              },
              onView: () {
                // View image
              },
              onDelete: () {
                controller.rcBookFront.value = '';
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
              fileName: controller.rcBookBack.value,
              fileSize: '',
              isUploaded: controller.rcBookBack.value.isNotEmpty,
              onUpload: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.rcBookBack.value = image.path.split('/').last;
                }
              },
              onView: () {
                // View image
              },
              onDelete: () {
                controller.rcBookBack.value = '';
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
            
            // RC Number Field
            Text(
              'RC number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter RC number',
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
            SizedBox(height: 16.h),
            
            // Expiry Date Field
            Text(
              'Expiry date',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
                );
                if (picked != null) {
                  controller.rcBookExpiry.value = picked;
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  children: [
                    Obx(() => Text(
                      controller.rcBookExpiry.value != null
                          ? '${controller.rcBookExpiry.value!.day} ${_getMonth(controller.rcBookExpiry.value!.month)} ${controller.rcBookExpiry.value!.year}'
                          : 'Select Date',
                      style: TextStyle(
                        color: controller.rcBookExpiry.value != null
                            ? Colors.black
                            : Colors.grey[600],
                      ),
                    )),
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
            SizedBox(height: 16.h),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: _canContinue() ? () {
                  controller.rcBookUploaded.value = true;
                  Get.back();
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
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
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          if (!isUploaded) ...[
            Icon(Icons.upload_file, color: Colors.grey[600], size: 24.w),
            SizedBox(width: 8.w),
            Text(
              'Upload',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onUpload,
              icon: Icon(Icons.add_circle_outline, color: Colors.grey[600], size: 24.w),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ] else ...[
            Icon(Icons.insert_drive_file, color: Colors.blue, size: 24.w),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (fileSize.isNotEmpty)
                    Text(
                      fileSize,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onView,
                  icon: Icon(Icons.visibility_outlined, color: Colors.grey[600], size: 24.w),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 16.w),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: Colors.grey[600], size: 24.w),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool _canContinue() {
    return controller.rcBookFront.value.isNotEmpty &&
           controller.rcBookBack.value.isNotEmpty &&
           controller.rcBookExpiry.value != null;
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
} 