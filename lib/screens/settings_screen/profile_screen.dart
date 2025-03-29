import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/document_screen/doc_upload.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Driver Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildProfileSection(controller),
            const Divider(height: 1, thickness: 1),
            _buildDocumentsList(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(ProfileController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Profile picture container
          Stack(
            children: [
              // Pink circular background with profile picture
              Hero(
                tag: 'profile-image',
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: const Color(0xFFFFB6C1),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.images.normal.user.path,
                            width: 120.r,
                            height: 120.r,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 60.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Edit button inside hero
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Name
          Obx(() => Text(
                controller.userName.value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
          SizedBox(height: 4.h),
          // Profile Picture text
          Text(
            'Profile Picture',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsList(ProfileController controller) {
    return Obx(() => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.documents.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) {
            final document = controller.documents[index];
            return _buildDocumentItem(document, controller);
          },
        ));
  }

  Widget _buildDocumentItem(Map<String, dynamic> document, ProfileController controller) {
    final bool isError = document['isError'] as bool;
    final bool isVerified = document['isVerified'] as bool;
    final String status = document['status'] as String;
    
    // Determine text color based on status content
    Color getStatusColor() {
      if (isError) return Colors.red;
      if (status.toLowerCase().contains('uploaded')) return Colors.green;
      if (status.toLowerCase().contains('verified')) return Colors.blue;
      return Colors.blue; // Default color
    }
    
    // Determine icon color based on status
    Color getIconColor() {
      if (isError) return Colors.red;
      if (status.toLowerCase().contains('uploaded')) return Colors.green;
      return Colors.blue; // Default for verified and others
    }
    
    // Determine icon background color
    Color getIconBgColor() {
      if (isError) return Colors.red.withOpacity(0.1);
      if (status.toLowerCase().contains('uploaded')) return Colors.green.withOpacity(0.1);
      return Colors.blue.withOpacity(0.1); // Default for verified and others
    }
    
    return InkWell(
      onTap: () => document['isError'] ? Get.to(() => const ReuploadDocumentScreen()) : controller.viewDocumentDetails(document['id'] as String),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: isError
              ? Border.all(color: Colors.red, width: 1)
              : null,
        ),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getIconBgColor(),
              ),
              child: Center(
                child: Icon(
                  isError 
                      ? Icons.close
                      : Icons.check,
                  color: getIconColor(),
                  size: 16.r,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            
            // Document title and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isError ? Colors.red : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: getStatusColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow icon
           SvgPicture.asset(Assets.images.icons.arrow)
          ],
        ),
      ),
    );
  }
} 