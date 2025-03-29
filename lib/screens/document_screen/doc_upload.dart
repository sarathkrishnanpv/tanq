import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'dart:io';

class ReuploadDocumentScreen extends StatefulWidget {
  const ReuploadDocumentScreen({Key? key}) : super(key: key);

  @override
  State<ReuploadDocumentScreen> createState() => _ReuploadDocumentScreenState();
}

class _ReuploadDocumentScreenState extends State<ReuploadDocumentScreen> {
  File? frontImage;
  File? backImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          if (isFront) {
            frontImage = File(image.path);
          } else {
            backImage = File(image.path);
          }
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle',style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.images.icons.redDoc),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drivers license date expired',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Upload the updated license to take rides back again',
                          style: TextStyle(fontSize: 12,color: Colors.red[900]),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(Assets.images.icons.arrow,colorFilter: ColorFilter.mode(Colors.red[900]!, BlendMode.srcIn),),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text('Front image:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () => _pickImage(true),
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: frontImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          frontImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40, color: Colors.grey[400]),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap to capture front image',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Back image:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () => _pickImage(false),
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: backImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          backImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40, color: Colors.grey[400]),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap to capture back image',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: frontImage != null && backImage != null
                    ? () {
                        // TODO: Implement upload functionality
                        Get.snackbar(
                          'Success',
                          'Images captured successfully!',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                child: Text('Re-upload',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}