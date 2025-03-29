import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';

class OtpVerificationSheet extends StatefulWidget {
  final String riderName;
  final VoidCallback onVerified;

  const OtpVerificationSheet({
    Key? key,
    required this.riderName,
    required this.onVerified,
  }) : super(key: key);

  @override
  State<OtpVerificationSheet> createState() => _OtpVerificationSheetState();
}

class _OtpVerificationSheetState extends State<OtpVerificationSheet> {
  final TextEditingController _pinController = TextEditingController();
  final RxBool _isVerifying = false.obs;
  String _enteredCode = '';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent dismissal with back button
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            
            Text(
              'Enter Rider OTP',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // PIN Input
            Center(
              child: Pinput(
                controller: _pinController,
                length: 4,
                defaultPinTheme: PinTheme(
                  width: 60.w,
                  height: 60.h,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 60.w,
                  height: 60.h,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onChanged: (value) {
                  _enteredCode = value;
                },
                onCompleted: (value) {
                  _enteredCode = value;
                },
              ),
            ),
            
            SizedBox(height: 16.h),
            
            Text(
              "We've sent a code to Mr. ${widget.riderName}. Enter the code to confirm your arrival at the destination location.",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            
           SizedBox(height: 25.h),
            
            Obx(() => ElevatedButton(
              onPressed: !_isVerifying.value 
                ? () {
                    if (_enteredCode.length == 4) {
                      _verifyOtp();
                    }
                  }
                : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: _isVerifying.value
                ? SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.w),
                  )
                : Text(
                    'Continue',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
            )),
            
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    _isVerifying.value = true;
    
    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, any 4-digit code is accepted
    _isVerifying.value = false;
    widget.onVerified();
  }
} 