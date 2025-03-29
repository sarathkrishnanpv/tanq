import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  const ChatScreen({Key? key, required this.userName}) : super(key: key);

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
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundImage: AssetImage(Assets.images.normal.user.path),
            ),
            SizedBox(width: 8.w),
            Text(
              userName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Secured messages banner
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  Assets.images.normal.messages3d.path,
                  width: 48.w,
                  height: 48.h,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Secured messages',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Ensures that messages can only be read by the sender and receiver, preventing interception by hackers or third parties.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildReceivedMessage('Bro where are you?', '2:32 PM'),
                _buildReceivedMessage('Can you share any landmark around you!', '2:32 PM'),
                _buildSentMessage('Bakery Junction hear gate no 3', '3:42 PM'),
              ],
            ),
          ),
          // Message input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentMessage(String message, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h, left: 60.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(String message, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h, right: 60.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}