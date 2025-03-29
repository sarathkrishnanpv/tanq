import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/screens/auth/add_mpin.dart';
import 'package:tanq.driver.app/screens/auth/registration/create_account.dart';
import 'package:tanq.driver.app/screens/auth/registration/terms_conditions.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_button.dart';
import 'package:tanq.driver.app/utils/app_images.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';
import 'package:tanq.driver.app/widgets/back_button.dart';
import 'package:tanq.driver.app/widgets/custom_checkbox.dart';
import 'package:tanq.driver.app/widgets/custom_textfield.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isChecked = false;
  final TextEditingController mobileNumebr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: Constants.height * 0.25,
              width: Constants.width,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.normal.loginBackground.path,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   BackArrowButton(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles().bold(
                            text: "Enter your mobile number",
                            size: 18,
                            color: AppColors.backgroundColor,
                          ),
                          AppStyles().med(
                            text: "Use your registered number to proceed  🇮🇳",
                            size: 14,
                            color: AppColors.backgroundColor,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            const Threeh(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomTextfield(
                    controller: mobileNumebr,
                    label: "MOBILE NUMBER",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCheckbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  const Twow(),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I Accept all the ',
                            style: AppStyles()
                                .reg(
                                  text: "",
                                  size: 12,
                                )
                                .style,
                          ),
                          TextSpan(
                            text: 'terms and conditions',
                            style: AppStyles()
                                .med(
                                  text: "",
                                  size: 12,
                                  color: AppColors.blue,
                                  decoration: TextDecoration.underline,
                                )
                                .style,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const TermsAndConditionsScreen());
                              },
                          ),
                          TextSpan(
                            style: AppStyles()
                                .reg(
                                  text: "",
                                  size: 12,
                                )
                                .style,
                            text: ' of tanQ',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Sevenh(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppButton(
                      onTap: () {
                        Get.to(() => const AddMpin());
                      },
                      text: "Continue",
                      icon: true,
                      iconData: SvgPicture.asset(
                        Assets.images.icons.arrow,
                      )),
                  AppButton(
                    onTap: () {
                      Get.to(() => const CreateAccount(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500));
                    },
                    text: "Create an account",
                    icon: false,
                    iconData: Container(),
                    textColor: AppColors.black,
                    buttonColor: AppColors.backgroundColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
