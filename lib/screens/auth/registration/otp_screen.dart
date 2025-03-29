import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/auth/add_mpin.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';


import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/global.dart';
import '../../../../utils/reusablespacing.dart';
import '../../../../widgets/back_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final ValueNotifier<bool> resendEnabled = ValueNotifier(true);
  final ValueNotifier<int> countdown = ValueNotifier(30);
  Timer? _timer;
  bool button = false;
  void startResendCountdown() {
    resendEnabled.value = false;
    countdown.value = 30;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  /// Mock function to handle OTP resend logic
  void resendOtp(String mobileNumber) {
    debugPrint("Resending OTP to $mobileNumber");

    startResendCountdown();
  }

  void buttonTrue() {
    setState(() {
      button = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Constants.height * 0.25,
              width: Constants.width,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.normal.loginBackground.path),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackArrowButton(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles().bold(
                          text: "Verify your phone number",
                          size: 18,
                          color: AppColors.backgroundColor,
                        ),
                        AppStyles().reg(
                          text:
                              "We sent you a 4-digit code to your \nphone number",
                          size: 14,
                          color: AppColors.backgroundColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Threeh(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Pinput(
                    length: 4,
                    onCompleted: (value) {
                      buttonTrue();
                    },
                    isCursorAnimationEnabled: true,
                    showCursor: true,
                    autofocus: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 24),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                  ),
                  const Twoh(),
                  ValueListenableBuilder(
                    valueListenable: countdown,
                    builder: (context, secondsLeft, child) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resend OTP\t\t',
                              style: AppStyles().reg(text: "", size: 12).style,
                              recognizer: resendEnabled.value
                                  ? (TapGestureRecognizer()
                                    ..onTap = () => startResendCountdown())
                                  : null,
                            ),
                            TextSpan(
                              text:
                                  resendEnabled.value ? '' : '${secondsLeft}s',
                              style: AppStyles()
                                  .reg(
                                    text: "",
                                    size: 12,
                                    color: resendEnabled.value
                                        ? AppColors.primary
                                        : Colors.black.withOpacity(0.8),
                                  )
                                  .style,
                              recognizer: resendEnabled.value
                                  ? (TapGestureRecognizer()
                                    ..onTap = () => startResendCountdown())
                                  : null,
                            ),
                            const WidgetSpan(child: Onew()),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SvgPicture.asset(
                                  colorFilter: const ColorFilter.mode(
                                      Color(0xff000000), BlendMode.srcIn),
                                  Assets.images.icons.arrow,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                  const Sevenh(),
                  AppButton(
                      onTap: () {
                        Get.to(() => AddMpin(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 500));
                      },
                      text: "Continue",
                      buttonColor: button
                          ? AppColors.black
                          : AppColors.black.withOpacity(0.3),
                      iconData: SvgPicture.asset(
                        Assets.images.icons.arrow,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
